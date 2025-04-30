#!/bin/bash

input_file="$1"
temp_file="${input_file}.tmp"

# Check if input file is provided
if [[ -z "$input_file" ]]; then
  echo "Usage: $0 <input_file>"
  exit 1
fi

# Step 1: Find the max number of tabs in any line
max_tabs=$(awk -F'\t' '{if (NF-1 > max) max = NF-1} END {print max}' "$input_file")

# Step 2: Pad each line with extra tabs to reach max_tabs
awk -v max="$max_tabs" -F'\t' '{
    extra = max - (NF - 1)
    printf "%s", $1
    for (i = 2; i <= NF; i++) {
        printf "\t%s", $i
    }
    for (i = 0; i < extra; i++) {
        printf "\t"
    }
    printf "\n"
}' "$input_file" > "$temp_file"

# Step 3: Replace the original file
mv "$temp_file" "$input_file"