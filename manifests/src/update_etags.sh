#!/usr/bin/env bash
# Fetch updated ETag values for URLs in a CSV file.

input_file="$1"

# Check if input file is provided
if [ -z "${input_file}" ]; then
  echo "Usage: $0 <input_file>"
  exit 1
fi

url_column=$(head -n1 "${input_file}" | tr ',' '\n' | grep -n "url" | cut -d':' -f1)
urls=$(awk -F',' -v col="$url_column" 'NR>1 {gsub(/^"|"$/, "", $col); print $col}' "${input_file}")

# Fetch ETags for each URL in a loop to avoid xargs command length issues
etag_values="etag"
while IFS= read -r url; do
  etag=$(curl -I --silent "${url}" | awk '/[eE][tT]ag:/ {print $2}' | tr -d '\r')
  etag_values+="\n${etag}"
done <<< "$urls"

# Remove existing ETag column if present
etag_column=$(head -n1 "${input_file}" | tr ',' '\n' | grep -n "etag" | cut -d':' -f1)

# Remove existing ETag column if present using cut
if [[ -n "$etag_column" ]]; then
    stripped_data=$(cut -d',' -f"1-$((etag_column-1)),$((etag_column+1))-" "${input_file}")
else
    stripped_data=$(cat "${input_file}")
fi

# Combine original data (without ETag) with new ETag values
paste -d',' <(echo "${stripped_data}") <(echo -e "${etag_values}")
