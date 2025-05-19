#!/bin/bash
#
# Swap two columns 

if [ "$#" -ne 3 ]; then
  echo "Usage: $0 <tsv_file> <col_index_1> <col_index_2>"
  exit 1
fi

input="$1"
col1="$2"
col2="$3"

awk -v c1="$col1" -v c2="$col2" 'BEGIN { FS=OFS="\t" }
{
  tmp = $c1
  $c1 = $c2
  $c2 = tmp
  print
}' "$input"