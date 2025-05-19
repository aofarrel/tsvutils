#!/bin/bash
#
# Add a column to a TSV

if [ "$#" -ne 3 ]; then
  echo "Usage: $0 <tsv_file> <new_header> <new_value>"
  exit 1
fi

input="$1"
new_col="$2"
value="$3"

awk -v colname="$new_col" -v val="$value" '
BEGIN { OFS = "\t" }
NR == 1 {
  print $0, colname
  next
}
{
  print $0, val
}
' "$input"