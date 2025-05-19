#!/bin/bash
#
# Take in a TSV/CSV, turn into a dataframe with polars,
# aggregate by a column name, and then print out resulting
# dataframe in same format it was input as.
#
# REQUIRES PYTHON POLARS

if [ $# -eq 0 ]; then
  echo "Usage: $0 <csv_or_tsv_file> <column_to_agg_upon>"
  echo "Requires python-polars"
  echo "csv_or_tsv_file: input file"
  echo "column_to_agg_upon: case-sensitive"
  exit 1
fi

INPUT_FILE="$1"
COLUMN="$2"
COUNT_COLUMNS="$3" # may be undefined

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
group_col = '$COLUMN'
sep = '$SEP'

df = pl.read_csv(input_file, separator=sep)
agg_df = df.group_by(group_col).agg(pl.all().first(), pl.len())
print(agg_df.write_csv(separator=sep))
"