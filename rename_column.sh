#!/bin/bash
#
# Rename a TSV column

if [ "$#" -ne 3 ]; then
  echo "Usage: $0 <tsv_file> <old_column_name> <new_column_name>"
  exit 1
fi

input_file="$1"
old_col="$2"
new_col="$3"

# Output modified TSV to stdout
awk -F'\t' -v OFS='\t' -v old="$old_col" -v new="$new_col" '
NR == 1 {
  for (i = 1; i <= NF; i++) {
    if ($i == old) $i = new
  }
}
{ print }
' "$input_file"
