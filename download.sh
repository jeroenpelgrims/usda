#!/bin/sh
echo "Finding most recent dataset files"
all_files=$(curl -s "https://fdc.nal.usda.gov/download-datasets/" \
  | grep -oP 'href="\K[^"]+' \
  | grep -oP "/fdc-datasets/.*?\.zip" \
  | sed 's|^|https://fdc.nal.usda.gov|')
foundation_food=$(echo "$all_files" | grep "foundation_food_csv" | sort | tail -1)
sr_legacy=$(echo "$all_files" | grep "sr_legacy_food_csv" | sort | tail -1)
echo "	Foundation dataset: $(basename $foundation_food)"
echo "	SR Legacy dataset: $(basename $sr_legacy)"

echo "Downloading datasets"
curl -s -o /foundation.zip "$foundation_food" 
curl -s -o /legacy.zip "$sr_legacy" 

echo "Unzipping datasets"
unzip -jq /foundation.zip -d /foundation
unzip -jq /legacy.zip -d /legacy


ls /foundation
ls /legacy
