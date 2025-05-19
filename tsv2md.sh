#!/bin/bash
#
# Convert a TSV into a markdown table

if [ "$#" -ne 1 ]; then
  echo "Usage: $0 <tsv_file>"
  exit 1
fi

input_file="$1"

awk -F'\t' '
BEGIN { OFS = "|" }
NR == 1 {
  # Print header row
  printf "|"
  for (i = 1; i <= NF; i++) printf " %s |", $i
  printf "\n|"
  for (i = 1; i <= NF; i++) printf " --- |"
  print ""
  next
}
{
  printf "|"
  for (i = 1; i <= NF; i++) printf " %s |", $i
  print ""
}
' "$input_file"