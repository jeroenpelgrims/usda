#!/bin/sh

DB_FILE=/out/usda.db


# Remove old file if it exists
rm -f $DB_FILE


# Create tables and staging tables
echo "Creating tables"
sqlite3 $DB_FILE < /schema.sql


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
skip=""
for folder in $FOLDERS; do
	for file in $FILES; do
		file_path="/${folder}/${file}.csv"
		table_name="${file}_staging"
		echo "Importing '${file_path}' into $table_name"
		sqlite3 "$DB_FILE" <<-EOF
			.mode csv
			.import ${skip} '$file_path' ${table_name}
		EOF
	done
	# When a table doesn't exist the first row of a csv is considered as column names
	# When the table already exists, sqlite will consider all rows as data
	skip="--skip 1"
done


# Filter & import from staging to real tables
echo "Importing into real tables"
sqlite3 "$DB_FILE" < /import.sql
