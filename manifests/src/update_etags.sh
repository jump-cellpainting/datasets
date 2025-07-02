#!/usr/bin/env bash
# Fetch updated ETag values for URLs in a json file
# Usage: `bash update_etags.sh profile_index.json`

input_file="$1"

urls=$(jq '.[].url' "${input_file}" | tr -d '"')

# Pull and clean the etag from the AWS url
NEW_ETAGS=$(echo "$urls" | while IFS= read -r url; do
    curl -I --silent "$url" | awk '/ETag:/ {print $2}' | tr -d '"' | tr -d '\r'
done)
# Format the list into json
JSON_LIST=$(printf '%s\n' "${NEW_ETAGS}" | jq -R . | jq -s .)

# Print again the list with the updated etag
# Note that this assumes that every entry provides an etag
jq --argjson etags "${JSON_LIST}" '[
  range(0; length) as $i
  | {subset: .[$i].subset, url: .[$i].url, recipe_permalink: .[$i].recipe_permalink, config_permalink: .[$i].config_permalink, etag: $etags[$i]}
]' ${input_file}
