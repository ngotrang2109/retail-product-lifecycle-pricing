-- DuckDB demo pipeline runner

CREATE OR REPLACE TABLE raw_product AS
SELECT * FROM read_csv_auto('data/raw/raw_product.csv');

CREATE OR REPLACE TABLE raw_launch_time AS
SELECT * FROM read_csv_auto('data/raw/raw_launch_time.csv');

CREATE OR REPLACE TABLE raw_order AS
SELECT * FROM read_csv_auto('data/raw/raw_order.csv');

CREATE OR REPLACE TABLE raw_bill AS
SELECT * FROM read_csv_auto('data/raw/raw_bill.csv');

CREATE OR REPLACE TABLE raw_bill_imex AS
SELECT * FROM read_csv_auto('data/raw/raw_bill_imex.csv');

.read sql/01_cleaning.sql
.read sql/02_quality_checks.sql
.read sql/03_integration.sql
.read sql/04_transformation.sql
.read sql/05_aggregation.sql
