-- =====================================
-- 05_aggregation.sql
-- Purpose: Analytics-ready data marts
-- =====================================

-- Daily SKU fact
CREATE OR REPLACE TABLE dm_daily_sku AS
SELECT
    order_date,
    sku_code,
    lifecycle_stage,
    pricing_strategy,
    SUM(total_sold_qty) AS total_sold_qty,
    MAX(inventory_remain) AS inventory_remain
FROM trf_daily_sku_lifecycle
GROUP BY order_date, sku_code, lifecycle_stage, pricing_strategy;

-- SKU lifecycle snapshot
CREATE OR REPLACE TABLE dm_sku_snapshot AS
SELECT
    sku_code,
    lifecycle_stage,
    pricing_strategy,
    MAX(sku_age) AS sku_age,
    MAX(inventory_remain) AS inventory_remain,
    SUM(total_sold_qty) AS total_sold_qty
FROM trf_daily_sku_lifecycle
GROUP BY sku_code, lifecycle_stage, pricing_strategy;
