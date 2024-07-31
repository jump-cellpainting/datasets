#!/usr/bin/env bash
# Returns the updated ETag for elements in the second column of $1 alongside the first two columns.
cat $1 |
    tail -n +2 | # Remove headers
 cut -f2 -d',' | # Select url column
 xargs -I {} -- curl -I --silent "{}" | # Fetch remote metadata 
 grep "ETag" |  # Select and clean etags
 awk '{print $2}' | # Remove prefix
 sed 's/\r$//' | # Remove carriage
 sed 1i'"etag"' | # add header
 paste - $1 -d',' | # Merge with original file
 awk -F ',' '{print $2","$3","$1}' # Print in the right order
