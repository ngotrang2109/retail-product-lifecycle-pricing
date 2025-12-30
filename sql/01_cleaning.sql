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
    quantity AS sold_quantity,
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

    CASE
        WHEN type = 2 AND mode = 2 THEN quantity     -- offline sale
        ELSE 0
    END AS offline_sold_quantity,

    CASE
        WHEN type = 2 AND mode = 6 THEN quantity     -- wholesale sale
        ELSE 0
    END AS wholesale_quantity,

    CASE
        WHEN type = 1 THEN quantity                  -- return / exchange
        ELSE 0
    END AS return_quantity,

    price,
    discount
FROM raw_bill
WHERE sku_code IS NOT NULL;

-- Clean inventory movement (bill_imex)
CREATE OR REPLACE TABLE stg_bill_imex AS
SELECT
    bill_id,
    CAST(order_date AS DATE) AS order_date,
    UPPER(TRIM(sku_code)) AS sku_code,
    mode_name,
    ABS(quantity) AS quantity,

    -- Inventory input (stock in)
    CASE
        WHEN mode_name IN ('[N]') THEN ABS(quantity)
        ELSE 0
    END AS input_quantity,

    -- Inventory output (stock out)
    CASE
        WHEN mode_name IN ('[B]', '[L]') THEN ABS(quantity)
        ELSE 0
    END AS output_quantity,

    -- Inventory adjustment
    CASE
        WHEN mode_name IN ('[DC+]', '[DC-]') THEN
            CASE
                WHEN mode_name = '[DC+]' THEN ABS(quantity)
                ELSE -ABS(quantity)
            END
        ELSE 0
    END AS adjust_quantity

FROM raw_bill_imex
WHERE sku_code IS NOT NULL;
