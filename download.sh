#!/bin/sh

# Define where the files will be output
output_folder="${1:-out}"
foundation_folder="${output_folder}/foundation"
legacy_folder="${output_folder}/legacy"
rm -rf $foundation_folder $legacy_folder
mkdir -p $foundation_folder $legacy_folder


# Find urls of data files
echo "Finding most recent dataset files"
all_files=$(curl -s "https://fdc.nal.usda.gov/download-datasets/" \
  | grep -oP 'href="\K[^"]+' \
  | grep -oP "/fdc-datasets/.*?\.zip" \
  | sed 's|^|https://fdc.nal.usda.gov|')
foundation_food=$(echo "$all_files" | grep "foundation_food_csv" | sort | tail -1)
sr_legacy=$(echo "$all_files" | grep "sr_legacy_food_csv" | sort | tail -1)
echo "	Foundation dataset: $(basename $foundation_food)"
echo "	SR Legacy dataset: $(basename $sr_legacy)"

# Download data files
echo "Downloading datasets"
curl -s -o "${foundation_folder}.zip" "$foundation_food" 
curl -s -o "${legacy_folder}.zip" "$sr_legacy" 

# Unzip data files
echo "Unzipping datasets"
unzip -jq "${foundation_folder}.zip" -d "${foundation_folder}" 
unzip -jq "${legacy_folder}.zip"  -d "${legacy_folder}" 

# Cleaning up
echo "Deleting zip files"
rm "${foundation_folder}.zip" 
rm "${legacy_folder}.zip" 
