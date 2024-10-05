#!/usr/bin/env bash
# Fetch updated ETag values for URLs in a CSV file.

input_file="$1"

# Check if input file is provided
if [ -z "$input_file" ]; then
  echo "Usage: $0 <input_file>"
  exit 1
fi

# Extract URLs using csvkit (assuming URL column is named 'url')
urls=$(csvcut -c url "$input_file" | tail -n +2)

# Fetch ETags for each URL in a loop to avoid xargs command length issues
etag_values="etag"
while IFS= read -r url; do
  etag=$(curl -I --silent "$url" | awk '/[eE][tT]ag:/ {print $2}' | tr -d '\r')
  etag_values+="\n$etag"
done <<< "$urls"

# Remove existing ETag column if present using csvcut
stripped_data=$(csvcut -C etag "$input_file" 2>/dev/null || cat "$input_file")

# Combine original data (without ETag) with new ETag values
paste -d',' <(echo "$stripped_data") <(echo -e "$etag_values")
