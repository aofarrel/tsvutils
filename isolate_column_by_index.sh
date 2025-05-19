#!/bin/bash
#
# Remove all columns except for one

input_file="$1"
column_number="$2"
extension="${input_file##*.}"

if [ $# -eq 0 ]; then
  echo "Usage: $0 <csv_or_tsv_file> <column_number>"
  echo "Column numbering is 1-indexed (eg, first column is 1)"
  echo "Input file is expected to end in .tsv or .csv"
  exit 1
fi

if [[ "$extension" == "tsv" ]]; then
  awk -F '	' "{print \$$column_number}" "$1"
elif [[ "$extension" == "csv" ]]; then
  awk -F ',' "{print \$$column_number}" "$1"
else
  echo "Unknown file type, check extension"
fi

