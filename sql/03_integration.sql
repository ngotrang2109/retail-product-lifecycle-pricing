-- =====================================
-- 03_integration.sql
-- Purpose: Integrate online, offline, inventory transactions
-- =====================================

-- 1. Online sales aggregation
-- 1. Online sales aggregation
CREATE OR REPLACE TABLE int_online_sales AS
SELECT
    order_date,
    sku_code,
    SUM(quantity) AS online_sold_qty,
    SUM(quantity * (price - discount)) AS online_revenue
FROM stg_order
WHERE status_code = 'Success'
GROUP BY order_date, sku_code;

-- 2. Offline & wholesale sales aggregation
CREATE OR REPLACE TABLE int_offline_sales AS
SELECT
    order_date,
    sku_code,

    SUM(CASE WHEN mode = 2 THEN quantity ELSE 0 END) AS offline_sold_qty,
    SUM(CASE WHEN mode = 6 THEN quantity ELSE 0 END) AS wholesale_qty,
    SUM(CASE WHEN mode = 3 THEN quantity ELSE 0 END) AS return_qty

FROM stg_bill
GROUP BY order_date, sku_code;

-- 3. Inventory movement aggregation
CREATE OR REPLACE TABLE int_inventory_movement AS
SELECT
    order_date,
    sku_code,
    SUM(input_quantity) AS input_qty,
    SUM(output_quantity) AS output_qty
FROM stg_bill_imex
GROUP BY order_date, sku_code;

-- 4. Unified daily SKU fact
CREATE OR REPLACE TABLE int_daily_sku AS
SELECT
    COALESCE(o.order_date, f.order_date, i.order_date) AS order_date,
    COALESCE(o.sku_code,  f.sku_code,  i.sku_code)  AS sku_code,

    -- Sales
    COALESCE(o.online_sold_qty, 0)  AS online_sold_qty,
    COALESCE(f.offline_sold_qty, 0) AS offline_sold_qty,
    COALESCE(f.wholesale_qty, 0)    AS wholesale_qty,
    COALESCE(f.return_qty, 0)       AS return_qty,

    -- Inventory movements
    COALESCE(i.input_qty, 0)  AS input_qty,
    COALESCE(i.output_qty, 0) AS output_qty,

    -- Revenue
    COALESCE(o.online_revenue, 0) AS online_revenue

FROM int_online_sales o
FULL JOIN int_offline_sales f
  ON o.order_date = f.order_date
 AND o.sku_code  = f.sku_code
FULL JOIN int_inventory_movement i
  ON COALESCE(o.order_date, f.order_date) = i.order_date
 AND COALESCE(o.sku_code,  f.sku_code)  = i.sku_code;
