#!/bin/sh

# Create tables and staging tables
sqlite3 /out/usda.db < /schema.sql

# Import data to staging tables
FOLDERS="
	foundation
	legacy
"
FILES="
	food
	food_nutrient
	nutrient
	food_category
	food_portion
	measure_unit
"
for folder in $FOLDERS; do
	for file in $FILES; do
		file_path="/${folder}/${file}.csv"
		table_name="${file}_staging"
		echo "Importing '${file_path}' into $table_name"
		# sqlite3 /out/usda.db ".import '$file_path' ${file}_staging"
		sqlite3 /out/usda.db <<-EOF
			.mode csv
			.import '$file_path' ${table_name}
		EOF
	done
done
