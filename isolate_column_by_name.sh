#!/bin/bash
#
# Remove all columns except specified ones
#
# REQUIRES PYTHON POLARS

if [ $# -ne 2 ]; then
  echo "Usage: $0 <csv_or_tsv_file> <columns_to_keep>"
  echo "Requires python-polars, columns_to_keep is case sensitive and comma-separated"
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
keep_cols = '$COLUMN'.split(',')
sep = '$SEP'

df = pl.read_csv(input_file, separator=sep).select(keep_cols)
print(df.write_csv(separator=sep))
"