# Retail Product Lifecycle & Pricing Strategy

## 📌 Overview
This personal project analyzes retail sales and inventory data to support product lifecycle management, pricing strategy, inventory planning and operational decision-making.

The project is designed from a **Business Analyst (Retail / Operations)** perspective, focusing on business logic, data-driven insights and process improvement commonly applied in real retail environments.

---

## 🎯 Business Objectives
- Classify products by lifecycle stage based on sales performance
- Identify key and potential products to support pricing and marketing strategies
- Reduce stockout and overstock risks through demand forecasting and restock planning
- Improve operational efficiency through production and marketing workflow design
- Support data-driven pricing and inventory decisions

---

## 🧩 Business Problems
Retail businesses often face:
- Static pricing applied across different product stages
- Limited visibility into key vs potential products
- Inventory imbalance causing stock shortages or excess stock
- Slow operational and marketing response to sales trends

---

## 📊 Data Sources
Simulated omnichannel retail data:
- Sales transactions (in-store and online)
- Inventory levels
- Product master data

### Key Fields
| Field | Description |
|------|------------|
| product_id | Product identifier |
| sales_date | Transaction date |
| quantity_sold | Units sold |
| price | Selling price |
| inventory_level | Available stock |

---

## 🔗 Data Integration & Transformation (SQL)
Sales and inventory data from multiple sources are integrated and aggregated using SQL.

Key activities:
- Monthly sales aggregation
- Average inventory calculation
- Data joining using CTEs

```sql
WITH sales_monthly AS (
    SELECT
        product_id,
        DATE_TRUNC('month', sales_date) AS month,
        SUM(quantity_sold) AS total_sales
    FROM sales
    GROUP BY product_id, DATE_TRUNC('month', sales_date)
),
inventory_avg AS (
    SELECT
        product_id,
        DATE_TRUNC('month', inventory_date) AS month,
        AVG(inventory_level) AS avg_inventory
    FROM inventory
    GROUP BY product_id, DATE_TRUNC('month', inventory_date)
)
SELECT
    s.product_id,
    s.month,
    s.total_sales,
    i.avg_inventory
FROM sales_monthly s
LEFT JOIN inventory_avg i
ON s.product_id = i.product_id
AND s.month = i.month;
