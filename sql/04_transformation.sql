-- =====================================
-- 04_transformation.sql
-- Purpose: Business logic & lifecycle transformation
-- =====================================

CREATE OR REPLACE TABLE trf_daily_sku AS
SELECT
    d.order_date,
    d.sku_code,

    -- Sales
    (online_sold_qty + offline_sold_qty + wholesale_qty) AS total_sold_qty,
    online_revenue,

    -- Inventory calculation (cumulative)
    SUM(input_qty - (online_sold_qty + offline_sold_qty + wholesale_qty))
        OVER (PARTITION BY d.sku_code ORDER BY d.order_date) AS inventory_remain,

    -- Launch info
    l.launch_date,
    DATE_DIFF('day', l.launch_date, d.order_date) + 1 AS sku_age

FROM int_daily_sku d
LEFT JOIN stg_launch_time l
  ON d.sku_code = l.sku_code
WHERE l.launch_date IS NOT NULL;

--Lifecycle & Pricing Logic
CREATE OR REPLACE TABLE trf_daily_sku_lifecycle AS
SELECT *,
    CASE
        WHEN sku_age <= 30 THEN 'New'
        WHEN total_sold_qty / NULLIF(sku_age, 0) >= 2 THEN 'Growth'
        WHEN total_sold_qty / NULLIF(sku_age, 0) < 1 THEN 'Decline'
        ELSE 'Maturity'
    END AS lifecycle_stage,

    CASE
        WHEN sku_age <= 30 THEN 'Maintain list price'
        WHEN total_sold_qty / NULLIF(sku_age, 0) >= 2 THEN 'Tactical promotion'
        WHEN total_sold_qty / NULLIF(sku_age, 0) < 1 THEN 'Controlled clearance'
        ELSE 'Selective discount'
    END AS pricing_strategy
FROM trf_daily_sku;
