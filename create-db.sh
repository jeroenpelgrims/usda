#!/bin/sh

DB_FILE=/out/usda.db


# Remove old file if it exists
rm -f $DB_FILE


# Create tables and staging tables
sqlite3 $DB_FILE < /schema.sql
sed -E \
	-e 's/(CREATE TABLE +[a-z_]+)/\1_staging/g' \
	-e 's/(REFERENCES +[a-z_]+)/\1_staging/g' \
	schema.sql | sqlite3 $DB_FILE


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
		sqlite3 $DB_FILE <<-EOF
			.mode csv
			.import '$file_path' ${table_name}
		EOF
	done
done


# Filter & import from staging to real tables
echo "Importing into real tables"
sqlite3 $DB_FILE < /import.sql
