# Data Fields Overview (Raw Layer)

This document provides a **lightweight overview of key fields** in the simulated
raw datasets used in the Retail Product Lifecycle & Pricing Strategy project.

The purpose is to clarify **business meaning**, not to serve as a full technical
data dictionary.

---

## 1. raw_product.csv  
**Simulated Source:** Product Master System

| Field | Description |
|-----|-------------|
| code | Unique product identifier used consistently across all datasets |
| product_name | Product display name |
| category_id | Product category used for lifecycle and performance grouping |
| price | Standard listed selling price |
| inventory_available | Current available inventory quantity |

---

## 2. raw_launch_time.csv  
**Simulated Source:** Product Launch / Batch Declaration (e.g. Google Sheets)

| Field | Description |
|-----|-------------|
| sku_code | Product identifier |
| launch_date | First available date used as the lifecycle starting point |
| inactive_date | Date when product is marked inactive or discontinued |

---

## 3. raw_order.csv  
**Simulated Source:** Online Order Management System

| Field | Description |
|-----|-------------|
| order_id | Unique online order identifier |
| created_date_time | Transaction date |
| sku_code | Product identifier |
| quantity | Units sold in the transaction |
| channel | Online sales channel (e-commerce, social, website) |
| price | Selling price per unit |
| discount | Applied discount amount (if any) |

---

## 4. raw_bill.csv  
**Simulated Source:** POS System

| Field | Description |
|-----|-------------|
| bill_id | Transaction identifier |
| created_date_time | Transaction date |
| sku_code | Product identifier |
| mode | Chanel (Offline sale, wholesale sale, or adjustment) |
| type | Transaction status (Success, Cancel) |
| quantity | Units sold or adjusted |
| price | Selling price per unit |
| discount | Applied discount amount (if any) |

---

## 5. raw_bill_imex.csv  
**Simulated Source:** Inventory In/Out & Exchange System

| Field | Description |
|-----|-------------|
| imex_id | Inventory movement identifier |
| created_date_time | Inventory movement date |
| sku_code | Product identifier |
| mode_name | Inventory in, out, exchange, or adjustment |
| quantity | Inventory change quantity |

---

## Notes
- All datasets are **synthetically generated** for portfolio demonstration.
- Only **business-critical fields** are documented here to maintain clarity and focus.

This lightweight documentation supports understanding of the SQL pipeline without introducing unnecessary technical complexity.
