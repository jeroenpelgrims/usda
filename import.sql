.mode csv

.print 'Importing to food'
INSERT OR IGNORE INTO food
SELECT *
FROM food_staging
WHERE data_type IN ('foundation_food', 'sr_legacy_food')
ORDER BY
	publication_date DESC,
	CASE data_type WHEN 'foundation_food' THEN 0 ELSE 1 END;

.print 'Importing to nutrient'
INSERT OR IGNORE INTO nutrient
SELECT DISTINCT ns.*
FROM nutrient_staging ns
INNER JOIN food_nutrient_staging fns
    ON CAST(fns.nutrient_id AS INTEGER) = ns.id
INNER JOIN food f
    ON CAST(fns.fdc_id AS INTEGER) = f.fdc_id;


.print 'Importing to food_nutrient'
iNSERT OR IGNORE INTO food_nutrient
SELECT fns.*
FROM food_nutrient_staging fns
INNER JOIN food f
    ON CAST(fns.fdc_id AS INTEGER) = f.fdc_id
INNER JOIN nutrient n
    ON CAST(fns.nutrient_id AS INTEGER) = n.id;


.print 'Importing to food_category'
INSERT OR IGNORE INTO food_category
SELECT * FROM food_category_staging;


.print 'Importing to measure_unit'
INSERT OR IGNORE INTO measure_unit
SELECT * FROM measure_unit_staging;


.print 'Importing to food_portion'
INSERT OR IGNORE INTO food_portion
SELECT fps.*
FROM food_portion_staging fps
INNER JOIN food f
    ON CAST(fps.fdc_id AS INTEGER) = f.fdc_id;
