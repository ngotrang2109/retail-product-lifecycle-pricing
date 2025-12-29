-- =====================================
-- 02_quality_checks.sql
-- Purpose: Data validation before integration
-- =====================================

-- 1. Orphan SKU in orders
SELECT DISTINCT o.sku_code
FROM stg_order o
LEFT JOIN stg_product p
  ON o.sku_code = p.sku_code
WHERE p.sku_code IS NULL;

-- 2. Orphan SKU in bills
SELECT DISTINCT b.sku_code
FROM stg_bill b
LEFT JOIN stg_product p
  ON b.sku_code = p.sku_code
WHERE p.sku_code IS NULL;

-- 3. Negative import quantity (inventory risk)
SELECT *
FROM stg_bill
WHERE mode = 5   -- import
  AND quantity < 0;

-- 4. Duplicate daily orders per SKU
SELECT
    sku_code,
    order_date,
    COUNT(*) AS cnt
FROM stg_order
GROUP BY sku_code, order_date
HAVING COUNT(*) > 10;
