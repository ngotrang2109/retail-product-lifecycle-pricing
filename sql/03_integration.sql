-- =====================================
-- 03_integration.sql
-- Purpose: Integrate online, offline, inventory transactions
-- =====================================

-- Online sales aggregation
CREATE OR REPLACE TABLE int_online_sales AS
SELECT
    order_date,
    sku_code,
    SUM(quantity) AS online_sold_qty,
    SUM(quantity * (price - discount)) AS online_revenue
FROM stg_order
WHERE status_code = 'Success'
GROUP BY order_date, sku_code;

-- Offline / inventory aggregation
CREATE OR REPLACE TABLE int_offline_sales AS
SELECT
    order_date,
    sku_code,
    SUM(CASE WHEN mode = 2 THEN quantity ELSE 0 END) AS offline_sold_qty,
    SUM(CASE WHEN mode = 6 THEN quantity ELSE 0 END) AS wholesale_qty,
    SUM(CASE WHEN mode = 5 THEN quantity ELSE 0 END) AS input_qty
FROM stg_bill
GROUP BY order_date, sku_code;

-- Unified daily SKU fact
CREATE OR REPLACE TABLE int_daily_sku AS
SELECT
    COALESCE(o.order_date, b.order_date) AS order_date,
    COALESCE(o.sku_code, b.sku_code) AS sku_code,
    COALESCE(online_sold_qty, 0) AS online_sold_qty,
    COALESCE(offline_sold_qty, 0) AS offline_sold_qty,
    COALESCE(wholesale_qty, 0) AS wholesale_qty,
    COALESCE(input_qty, 0) AS input_qty,
    COALESCE(online_revenue, 0) AS online_revenue
FROM int_online_sales o
FULL JOIN int_offline_sales b
USING (order_date, sku_code);
