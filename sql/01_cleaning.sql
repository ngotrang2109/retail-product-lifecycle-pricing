-- =====================================
-- 01_cleaning.sql
-- Purpose: Standardize raw data for downstream processing
-- =====================================

-- Clean product master
CREATE OR REPLACE TABLE stg_product AS
SELECT
    product_id,
    UPPER(TRIM(code)) AS sku_code_raw,
    UPPER(
        REGEXP_REPLACE(code, '(_.*|-.+)$', '')
        ) AS sku_code,
    name,
    price,
    category_id,
    inventory_damaged
FROM raw_product
WHERE code IS NOT NULL;

-- Clean launch / batch metadata
CREATE OR REPLACE TABLE stg_launch_time AS
SELECT
    UPPER(TRIM(sku_code)) AS sku_code,
    CAST(launch_date AS DATE) AS launch_date,
    CAST(inactive_date AS DATE) AS inactive_date,
    unit_variable_cost
FROM raw_launch_time;

-- Clean online orders
CREATE OR REPLACE TABLE stg_order AS
SELECT
    order_id,
    CAST(created_date_time AS DATE) AS order_date,
    UPPER(TRIM(sku_code)) AS sku_code,
    quantity,
    price,
    discount,
    status_code,
    sales_channel_name
FROM raw_order
WHERE quantity > 0
  AND sku_code IS NOT NULL;

-- Clean offline / inventory bills
CREATE OR REPLACE TABLE stg_bill AS
SELECT
    bill_id,
    CAST(created_date_time AS DATE) AS order_date,
    UPPER(TRIM(sku_code)) AS sku_code,
    quantity,
    price,
    discount,
    type,
    mode
FROM raw_bill
WHERE quantity <> 0;
