-- =====================================
-- 04_transformation.sql
-- Purpose: Lifecycle & pricing logic
-- =====================================

-- 1. Inventory & age
CREATE OR REPLACE TABLE trf_daily_sku AS
SELECT
    d.order_date,
    d.sku_code,

    (online_sold_qty + offline_sold_qty + wholesale_qty) AS total_sold_qty,
    online_revenue,

    -- Inventory on hand
    SUM(input_qty - output_qty)
        OVER (PARTITION BY d.sku_code ORDER BY d.order_date) AS inventory_remain,

    l.launch_date,
    DATE_DIFF('day', l.launch_date, d.order_date) + 1 AS sku_age

FROM int_daily_sku d
LEFT JOIN stg_launch_time l
  ON d.sku_code = l.sku_code
WHERE l.launch_date IS NOT NULL;

-- 2. Demand signals (FR5)
CREATE OR REPLACE TABLE trf_daily_sku_demand AS
SELECT
    *,

    -- Rolling average sales (last 7 days)
    AVG(total_sold_qty)
        OVER (
            PARTITION BY sku_code
            ORDER BY order_date
            ROWS BETWEEN 6 PRECEDING AND CURRENT ROW
        ) AS avg_daily_sales_7d

FROM trf_daily_sku;

-- 3. Lifecycle, product role & pricing strategy
CREATE OR REPLACE TABLE trf_daily_sku_lifecycle AS
SELECT *,
    -- Days on Hand (FR5)
    CASE
        WHEN avg_daily_sales_7d > 0
        THEN ROUND(inventory_remain / avg_daily_sales_7d, 1)
        ELSE NULL
    END AS days_on_hand,

    -- Stockout risk (FR5)
    CASE
        WHEN avg_daily_sales_7d > 0 AND inventory_remain / avg_daily_sales_7d < 7
            THEN 'High'
        WHEN avg_daily_sales_7d > 0 AND inventory_remain / avg_daily_sales_7d BETWEEN 7 AND 21
            THEN 'Medium'
        ELSE 'Low'
    END AS stockout_risk,

    -- Average daily sales since launch
    CASE
        WHEN sku_age > 0 THEN
            SUM(total_sold_qty)
              OVER (PARTITION BY sku_code ORDER BY order_date)
            / sku_age
        ELSE NULL
    END AS avg_daily_sales,

    -- Lifecycle stage
    CASE
        WHEN sku_age <= 30 THEN 'New'
        WHEN avg_daily_sales >= 2 THEN 'Growth'
        WHEN avg_daily_sales < 1 THEN 'Decline'
        ELSE 'Maturity'
    END AS lifecycle_stage,

    -- Product role (FR4)
    CASE
        WHEN lifecycle_stage IN ('Growth', 'Maturity')
             AND avg_daily_sales_7d >= 2
            THEN 'Key'
        WHEN lifecycle_stage = 'Growth'
             AND avg_daily_sales_7d BETWEEN 1 AND 2
            THEN 'Potential'
        ELSE 'Other'
    END AS product_role,

    -- Pricing strategy
    CASE
        WHEN sku_age <= 30 THEN 'Maintain list price'
        WHEN avg_daily_sales >= 2 AND inventory_remain > 0 THEN 'Tactical promotion'
        WHEN avg_daily_sales < 1 AND inventory_remain > 0 THEN 'Controlled clearance'
        WHEN inventory_remain <= 0 THEN 'Hold / Restock'
        ELSE 'Selective discount'
    END AS pricing_strategy
FROM trf_daily_sku_demand;
