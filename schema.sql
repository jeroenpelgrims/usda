-- The central food table: every food item in the database
CREATE TABLE food (
    fdc_id           INTEGER PRIMARY KEY,
    data_type        TEXT NOT NULL,          -- e.g. 'branded_food', 'foundation_food', 'sr_legacy_food', 'survey_fndds_food'
    description      TEXT NOT NULL,          -- human-readable food name
    food_category_id TEXT,                   -- references food_category.id (integer for most types, but branded foods store the description text directly)
    publication_date DATE
);

-- The actual nutritional values: one row per nutrient per food
CREATE TABLE food_nutrient (
    id                INTEGER PRIMARY KEY,
    fdc_id            INTEGER NOT NULL REFERENCES food(fdc_id),
    nutrient_id       INTEGER NOT NULL REFERENCES nutrient(id),
    amount            NUMERIC,               -- amount per 100g (or per serving for some branded)
    data_points       TEXT,                  -- number of data points used (often empty for branded)
    derivation_id     TEXT,                  -- references food_nutrient_derivation.code
    min               NUMERIC,
    max               NUMERIC,
    median            NUMERIC,
    loq               TEXT,                  -- limit of quantification
    footnote          TEXT,
    min_year_acquired TEXT,
    percent_daily_value TEXT
);

-- The nutrient dictionary: translates nutrient_id into a name and unit
CREATE TABLE nutrient (
    id          INTEGER PRIMARY KEY,
    name        TEXT NOT NULL,               -- e.g. 'Energy (Atwater General Factors)', 'Protein', 'Total lipid (fat)'
    unit_name   TEXT NOT NULL,               -- e.g. 'KCAL', 'G', 'MG', 'UG'
    nutrient_nbr TEXT,                       -- USDA nutrient number
    rank        NUMERIC                      -- display ordering
);


-- Food category hierarchy
CREATE TABLE food_category (
    id          INTEGER PRIMARY KEY,
    code        TEXT,                        -- e.g. '0100'
    description TEXT NOT NULL                -- e.g. 'Dairy and Egg Products'
);

-- Serving size / portion data for each food
CREATE TABLE food_portion (
    id                  INTEGER PRIMARY KEY,
    fdc_id              INTEGER NOT NULL REFERENCES food(fdc_id),
    seq_num             INTEGER,             -- ordering for multiple portions per food
    amount              NUMERIC,             -- e.g. 1.0
    measure_unit_id     INTEGER REFERENCES measure_unit(id),
    portion_description TEXT,                -- e.g. 'serving', 'slice', '1 NLEA serving'
    modifier            TEXT,                -- e.g. 'large', 'medium'
    gram_weight         NUMERIC,             -- weight in grams for this portion
    data_points         TEXT,
    footnote           TEXT,
    min_year_acquired   TEXT
);

-- Measurement unit dictionary (cups, tbsp, etc.)
CREATE TABLE measure_unit (
    id   INTEGER PRIMARY KEY,
    name TEXT NOT NULL                       -- e.g. 'cup', 'tbsp', 'g', 'oz'
);

-- Branded / commercial product details
CREATE TABLE branded_food (
    fdc_id                       INTEGER PRIMARY KEY REFERENCES food(fdc_id),
    brand_owner                  TEXT,       -- e.g. 'Kellogg Company'
    brand_name                   TEXT,       -- e.g. 'Kellogg\'s'
    subbrand_name                TEXT,
    gtin_upc                     TEXT,       -- barcode / UPC
    ingredients                  TEXT,       -- full ingredients list
    not_a_significant_source_of  TEXT,
    serving_size                 TEXT,       -- e.g. '15.0'
    serving_size_unit            TEXT,       -- e.g. 'ml'
    household_serving_fulltext   TEXT,       -- e.g. '1 Tbsp (15 ml)'
    branded_food_category        TEXT,       -- e.g. 'Oils Edible'
    data_source                  TEXT,       -- e.g. 'GDSN', 'LI'
    package_weight               TEXT,
    modified_date                DATE,
    available_date               DATE,
    market_country               TEXT,       -- e.g. 'United States'
    discontinued_date            TEXT,
    preparation_state_code       TEXT,
    trade_channel                TEXT,
    short_description            TEXT,
    material_code                TEXT
);
