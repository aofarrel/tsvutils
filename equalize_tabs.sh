#!/bin/bash
#
# Equalize the number of tabs in a TSV file by adding ADDITIONAL tabs
# to lines that are lacking columns

input_file="$1"
temp_file="${input_file}.tmp"

# Find the max number of tabs in any line
max_tabs=$(awk -F'\t' '{if (NF-1 > max) max = NF-1} END {print max}' "$input_file")

# Pad each line with extra tabs to reach max_tabs
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

mv "$temp_file" "$input_file"