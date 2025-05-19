#!/bin/bash

# Scan input TSV linewise. Whenever there's more than 2 tabs, take that line and
# save it as a line in the output file. Back in the input file, truncate everything
# after the third tab (including the tab itself) in that line.

input_file="$1"
output_file="$2"
temp_file="truncated"

if [ $# -eq 0 ]; then
  echo "Usage: $0 <tsv_file> <output_name>"
  exit 1
fi

while IFS= read -r line; do
    tab_count=$(grep -o $'\t' <<< "$line" | wc -l)

    if (( tab_count > 2 )); then
        echo "$line" >> "$output_file"
        truncated=$(cut -f1-3 <<< "$line")
        echo -e "$truncated" >> "$temp_file"
    else
        echo "$line" >> "$temp_file"
    fi
done < "$input_file"

mv "$temp_file" "$input_file"