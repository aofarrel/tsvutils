#!/bin/bash

input_file="$1"
output_file="$2"
temp_file="truncated"

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