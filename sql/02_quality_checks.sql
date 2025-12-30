-- =====================================
-- 02_quality_checks.sql
-- Purpose: Data validation before integration
-- =====================================

-- 1. Orphan SKU in online orders
-- Orders referencing SKUs not found in product master
SELECT DISTINCT o.sku_code
FROM stg_order o
LEFT JOIN stg_product p
  ON o.sku_code = p.sku_code
WHERE p.sku_code IS NULL;

-- 2. Orphan SKU in offline / wholesale sales
SELECT DISTINCT b.sku_code
FROM stg_bill b
LEFT JOIN stg_product p
  ON b.sku_code = p.sku_code
WHERE p.sku_code IS NULL;

-- 3. Orphan SKU in inventory movements
SELECT DISTINCT i.sku_code
FROM stg_bill_imex i
LEFT JOIN stg_product p
  ON i.sku_code = p.sku_code
WHERE p.sku_code IS NULL;

-- 4. Invalid inventory movement quantities
-- Inventory input/output must be non-negative after standardization
SELECT *
FROM stg_bill_imex
WHERE input_quantity < 0
   OR output_quantity < 0;

-- 5. Abnormal daily order volume per SKU
-- Used to detect potential duplicates or data anomalies
SELECT
    sku_code,
    order_date,
    COUNT(*) AS order_count
FROM stg_order
GROUP BY sku_code, order_date
HAVING COUNT(*) > 5;

-- 6. Inventory movement types outside demo scope
-- Demo dataset focuses on sales outflow ([B], [L]) and stock-in ([N])
SELECT DISTINCT mode_name
FROM stg_bill_imex
WHERE mode_name NOT IN ('[N]', '[B]', '[L]');
