-- The central food table: every food item in the database
CREATE TABLE IF NOT EXISTS food (
    fdc_id           INTEGER PRIMARY KEY,
    data_type        TEXT NOT NULL,
    description      TEXT NOT NULL,
    food_category_id TEXT,
    publication_date DATE
);

-- The actual nutritional values: one row per nutrient per food
CREATE TABLE IF NOT EXISTS food_nutrient (
    id                INTEGER PRIMARY KEY,
    fdc_id            INTEGER NOT NULL REFERENCES food(fdc_id),
    nutrient_id       INTEGER NOT NULL REFERENCES nutrient(id),
    amount            NUMERIC,
    data_points       TEXT,
    derivation_id     TEXT,
    min               NUMERIC,
    max               NUMERIC,
    median            NUMERIC,
    loq               TEXT,
    footnote          TEXT,
    min_year_acquired TEXT,
    percent_daily_value TEXT
);

-- The nutrient dictionary: translates nutrient_id into a name and unit
CREATE TABLE IF NOT EXISTS nutrient (
    id          INTEGER PRIMARY KEY,
    name        TEXT NOT NULL,
    unit_name   TEXT NOT NULL,
    nutrient_nbr TEXT,
    rank        NUMERIC
);


-- Food category hierarchy
CREATE TABLE IF NOT EXISTS food_category (
    id          INTEGER PRIMARY KEY,
    code        TEXT,
    description TEXT NOT NULL
);

-- Serving size / portion data for each food
CREATE TABLE IF NOT EXISTS food_portion (
    id                  INTEGER PRIMARY KEY,
    fdc_id              INTEGER NOT NULL REFERENCES food(fdc_id),
    seq_num             INTEGER,
    amount              NUMERIC,
    measure_unit_id     INTEGER REFERENCES measure_unit(id),
    portion_description TEXT,
    modifier            TEXT,
    gram_weight         NUMERIC,
    data_points         TEXT,
    footnote           TEXT,
    min_year_acquired   TEXT
);

-- Measurement unit dictionary (cups, tbsp, etc.)
CREATE TABLE IF NOT EXISTS measure_unit (
    id   INTEGER PRIMARY KEY,
    name TEXT NOT NULL
);

-- Branded / commercial product details
CREATE TABLE IF NOT EXISTS branded_food (
    fdc_id                       INTEGER PRIMARY KEY REFERENCES food(fdc_id),
    brand_owner                  TEXT,
    brand_name                   TEXT,
    subbrand_name                TEXT,
    gtin_upc                     TEXT,
    ingredients                  TEXT,
    not_a_significant_source_of  TEXT,
    serving_size                 TEXT,
    serving_size_unit            TEXT,
    household_serving_fulltext   TEXT,
    branded_food_category        TEXT,
    data_source                  TEXT,
    package_weight               TEXT,
    modified_date                DATE,
    available_date               DATE,
    market_country               TEXT,
    discontinued_date            TEXT,
    preparation_state_code       TEXT,
    trade_channel                TEXT,
    short_description            TEXT,
    material_code                TEXT
);


-- Create staging tables
CREATE TABLE IF NOT EXISTS food_staging AS SELECT * FROM food WHERE 0;
CREATE TABLE IF NOT EXISTS food_nutrient_staging AS SELECT * FROM food_nutrient WHERE 0;
CREATE TABLE IF NOT EXISTS nutrient_staging AS SELECT * FROM nutrient WHERE 0;
CREATE TABLE IF NOT EXISTS food_category_staging AS SELECT * FROM food_category WHERE 0;
CREATE TABLE IF NOT EXISTS food_portion_staging AS SELECT * FROM food_portion WHERE 0;
CREATE TABLE IF NOT EXISTS measure_unit_staging AS SELECT * FROM measure_unit WHERE 0;
CREATE TABLE IF NOT EXISTS branded_food_staging AS SELECT * FROM branded_food WHERE 0;
