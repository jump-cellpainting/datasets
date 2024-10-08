#!/usr/bin/env bash
# Fetch updated ETag values for URLs in a CSV file.

# Note that quotes are expected in the csv but ommited when
input_file="$1"
url_header="url"
etag_header="etag"

get_column() {
	# gets id of column $1 in ${input_file}.
	awk -F',' -v col="\"$1\"" 'NR==1 { for (i=1; i<=NF; ++i) { if ($i==col) print i } }' "${input_file}"
}

# Check if input file is provided
if [ -z "${input_file}" ]; then
	echo "Usage: $0 <input_file>"
	exit 1
fi

url_column=$(get_column "${url_header}")
urls=$(awk -F',' -v col="${url_column}" 'NR>1 {gsub(/^"|"$/, "", $col); print $col}' "${input_file}")

# Fetch ETags for each URL in a loop
etag_values='"etag"'
while IFS= read -r url; do
	etag=$(curl -I --silent "${url}" | awk '/ETag:/ {print $2}')
	etag_values+="\n${etag}"
done <<<"$urls"

# Remove existing ETag column if present
etag_column=$(get_column "${etag_header}")

# Combine original data (without ETag) with new ETag values
if [[ -n "${etag_column}" ]]; then # Replace $etag_column in $input_file with $etag_values
	awk -F',' -v OFS=',' -v col="${etag_column}" 'NR==FNR{a[NR]=$1;next}{$col=a[FNR]}1' <(echo -e "${etag_values}") "${input_file}"
else # Append $etag_values as a new column on the right
	paste -d',' "${input_file}" <(echo -e "${etag_values}")
fi
