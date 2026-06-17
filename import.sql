.mode csv

INSERT OR IGNORE INTO food
SELECT * FROM food_staging;

INSERT OR IGNORE INTO nutrient
SELECT * FROM nutrient_staging;

INSERT OR IGNORE INTO food_nutrient
SELECT * FROM food_nutrient_staging;

INSERT OR IGNORE INTO food_category
SELECT * FROM food_category_staging;

INSERT OR IGNORE INTO measure_unit
SELECT * FROM measure_unit_staging;

INSERT OR IGNORE INTO food_portion
SELECT * FROM food_portion_staging;
