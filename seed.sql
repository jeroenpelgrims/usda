-- The central food table: every food item in the database
CREATE TABLE food (
    fdc_id           INTEGER PRIMARY KEY,
    data_type        TEXT NOT NULL,          -- e.g. 'branded_food', 'foundation_food', 'sr_legacy_food', 'survey_fndds_food'
    description      TEXT NOT NULL,          -- human-readable food name
    food_category_id TEXT,                   -- references food_category.id (integer for most types, but branded foods store the description text directly)
    publication_date DATE
);


-- COPY reads from the container's filesystem, not the host
COPY food(fdc_id, data_type, description, food_category_id, publication_date) FROM '/foundation/food.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',');
