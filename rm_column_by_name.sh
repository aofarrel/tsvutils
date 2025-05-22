#!/bin/bash
#
# Remove columns specified by name
#
# REQUIRES PYTHON POLARS

if [ $# -ne 2 ]; then
  echo "Usage: $0 <csv_or_tsv_file> <columns_to_discard>"
  echo "Requires python-polars, columns_to_discard is case sensitive and comma-separated"
  exit 1
fi

INPUT_FILE="$1"
COLUMN="$2"

EXT="${INPUT_FILE##*.}"
if [[ "$EXT" == "csv" ]]; then
  SEP=","
else
  SEP="\t"
fi

python3 -c "
import sys
import polars as pl

input_file = '$INPUT_FILE'
rm_cols = '$COLUMN'.split(',')
sep = '$SEP'

df = pl.read_csv(input_file, separator=sep)
keep_cols = [col for col in df.columns if col not in rm_cols]

print(df.select(keep_cols).write_csv(separator=sep))
"