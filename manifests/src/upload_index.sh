# Find the latest version of the dataset
ZENODO_ENDPOINT="https://zenodo.org"
DEPOSITION_PREFIX="${ZENODO_ENDPOINT}/api/deposit/depositions"
ORIGINAL_ID="13892001"
FILE_TO_VERSION="manifests/profile_index.csv"

echo "Checking that S3 ETags match their local counterpart"
S3_ETAGS=$(cat ${FILE_TO_VERSION} | tail -n +2 | cut -f2 -d',' | xargs -I {} -- curl -I --silent "{}" | grep ETag | awk '{print $2}' | sed 's/\r$//' | md5sum | cut -f1 -d" ")
LOCAL_ETAGS=$(cat ${FILE_TO_VERSION} | tail -n +2 | cut -f3 -d',' | md5sum | cut -f1 -d" ")

echo "Remote ${S3_ETAGS} vs Local ${LOCAL_ETAGS} values"
if [ "${S3_ETAGS}" != "${LOCAL_ETAGS}" ]; then
    echo "At least one ETag does not match their url."
    exit 1
fi

if [ -z "${ORIGINAL_ID}" ]; then # Only get latest id when provided an original one
    echo "Creating new deposition"
    DEPOSITION_ENDPOINT="${DEPOSITION_PREFIX}"
else # Update existing dataset
    echo "Previous ID Exists"
    LATEST_ID=$(curl "${ZENODO_ENDPOINT}/records/${ORIGINAL_ID}/latest" |
		    grep records | sed 's/.*href=".*\.org\/records\/\(.*\)".*/\1/')
    REMOTE_HASH=$(curl -H "Content-Type: application/json" -X GET  --data "{}" \
		       "${DEPOSITION_PREFIX}/${LATEST_ID}/files?access_token=${ZENODO_TOKEN}" |
		      jq ".[] .links .download" | xargs curl | md5sum | cut -f1 -d" ")
    LOCAL_HASH=$(md5sum ${FILE_TO_VERSION} | cut -f1 -d" ")

    echo "Checking for changes in file contents: Remote ${REMOTE_HASH} vs Local ${LOCAL_HASH}"
    if [ "${REMOTE_HASH}" == "${LOCAL_HASH}" ]; then
	echo "The urls and md5sums have not changed"
	exit 0
    fi

    echo "Creating new version"
    DEPOSITION_ENDPOINT="${DEPOSITION_PREFIX}/${LATEST_ID}/actions/newversion"
fi


if [ -z "${ZENODO_TOKEN}" ]; then # Check Zenodo Token
    echo "Access token not available"
    exit 1
else
    echo "Access token found."
fi


# Create new deposition
DEPOSITION=$(curl -H "Content-Type: application/json" \
		  -X POST\
		  --data "{}" \
		  "${DEPOSITION_ENDPOINT}?access_token=${ZENODO_TOKEN}"\
		 | jq .id)
echo "New deposition ID is ${DEPOSITION}"

# Variables
BUCKET_DATA=$(curl "${DEPOSITION_PREFIX}/$DEPOSITION?access_token=$ZENODO_TOKEN")
BUCKET=$(echo "${BUCKET_DATA}" | jq --raw-output .links.bucket)

if [ "${BUCKET}" = "null" ]; then
    echo "Could not find URL for upload. Response from server:"
    echo "${BUCKET_DATA}"
    exit 1
fi

# Upload file
echo "Uploading file ${FILE_TO_VERSION} to bucket ${BUCKET}"
cat ${FILE_TO_VERSION}
curl -o /dev/null \
     --upload-file ${FILE_TO_VERSION} \
     ${BUCKET}/${FILE_TO_VERSION}?access_token="${ZENODO_TOKEN}"


# Upload Metadata
echo -e '{"metadata": {
    "title": "The Joint Undertaking for Morphological Profiling (JUMP) Consortium Datasets Index",
    "creators": [
        {
            "name": "The JUMP Cell Painting Consortium"
        }
    ],
    "upload_type": "dataset",
    "access_right": "open"
}}' > metadata.json

NEW_DEPOSITION_ENDPOINT="${DEPOSITION_PREFIX}/${DEPOSITION}"
echo "Uploading file to ${NEW_DEPOSITION_ENDPOINT}"
curl -H "Content-Type: application/json" \
     -X PUT\
     --data @metadata.json \
     "${NEW_DEPOSITION_ENDPOINT}?access_token=${ZENODO_TOKEN}"

# Publish
echo "Publishing to ${NEW_DEPOSITION_ENDPOINT}"
curl -H "Content-Type: application/json" \
     -X POST\
     --data "{}"\
     "${NEW_DEPOSITION_ENDPOINT}/actions/publish?access_token=${ZENODO_TOKEN}"\
    | jq .id

