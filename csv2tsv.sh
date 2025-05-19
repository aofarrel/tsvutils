#!/bin/bash
#
# Turn a CSV into a TSV using Python. Using Python allows us to
# avoid improperly turning commas within "dquotes" into tabs.

if [ $# -eq 0 ]; then
  echo "Usage: $0 <csv_file>"
  exit 1
fi

python3 -c '
import csv, sys
reader = csv.reader(sys.stdin)
writer = csv.writer(sys.stdout, delimiter="\t", lineterminator="\n")
for row in reader:
    writer.writerow(row)
' < "$1"
