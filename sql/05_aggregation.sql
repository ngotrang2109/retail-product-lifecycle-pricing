-- =====================================
-- 05_aggregation.sql
-- Purpose: Analytics-ready data marts
-- =====================================

-- 1. Daily SKU fact (one row per SKU per day)
CREATE OR REPLACE TABLE dm_daily_sku AS
SELECT
    order_date,
    sku_code,
    lifecycle_stage,
    pricing_strategy,
    product_role,
    total_sold_qty,
    inventory_remain,
    avg_daily_sales_7d,
    days_on_hand,
    stockout_risk
FROM trf_daily_sku_lifecycle;

-- 2. SKU lifecycle snapshot (latest state per SKU)
CREATE OR REPLACE TABLE dm_sku_snapshot AS
SELECT
    sku_code,
    lifecycle_stage,
    product_role,
    pricing_strategy,
    sku_age,
    inventory_remain,
    total_sold_qty,
    avg_daily_sales,
    total_sold_qty,
    avg_daily_sales_7d,
    days_on_hand,
    stockout_risk
FROM (
    SELECT
        *,
        ROW_NUMBER() OVER (
            PARTITION BY sku_code
            ORDER BY order_date DESC
        ) AS rn
    FROM trf_daily_sku_lifecycle
)
WHERE rn = 1;
