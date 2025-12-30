# Data Mart Usage Guide

## 1. Purpose
This document describes how the analytics data marts are used to support
business decision-making related to product lifecycle management,
pricing strategy, and inventory planning.

The data marts are designed to be business-friendly and interpretable
by non-technical stakeholders.

---

## 2. Data Mart Overview
Two primary data marts are delivered as part of this solution:

- dm_daily_sku
- dm_sku_snapshot

Each data mart serves a distinct decision-making purpose.

---

## 3. dm_daily_sku

### 3.1 Description
**Grain:** SKU × Date (daily snapshot)

The dm_daily_sku data mart provides daily visibility into sales performance,
inventory movement, and lifecycle status at SKU level.

### 3.2 Primary Users
- Merchandising team
- Sales Manager
- Marketing team

### 3.3 Key Business Questions Supported
- How is each SKU performing on a daily basis?
- Are there early signs of overstock or stockout risk?
- How is inventory changing over time for each product?
- How does lifecycle status evolve after launch?
- Does SKU's marketing action impact to sales performance?

### 3.4 Typical Business Use Cases
- Daily and weekly sales monitoring
- Early detection of slow-moving products
- Tracking inventory trends for restock planning
- Monitoring lifecycle transitions (e.g. Growth to Maturity)
- Tracking sales trend after marketing actions?

### 3.5 Example Usage
- Prodution Operation Managers use dm_daily_sku to review daily sales and inventory trends, and identify products that require pricing or inventory actions.
- Marketing team use dm_daily_sku to review daily sales and sales trends, and identify result of marketing actions impact to products.
---

## 4. dm_sku_snapshot

### 4.1 Description
**Grain:** SKU (latest available state)

The dm_sku_snapshot data mart represents the most recent lifecycle,
pricing strategy, and inventory status of each SKU.

### 4.2 Primary Users
- Sales Managers
- Production Operation Managers
- Marketing team
- Business Stakeholders

### 4.3 Key Business Questions Supported
- What is the current lifecycle stage of each SKU?
- Which products are classified as Key or Potential?
- Which SKUs require promotion, clearance, or restock actions?
- What pricing strategy should be applied now?

### 4.4 Typical Business Use Cases
- Weekly pricing and promotion review
- Clearance and markdown planning
- Assortment optimization decisions
- Management reporting and business review

### 4.5 Example Usage
- Prodution Operation managers and Marketing team use dm_sku_snapshot during weekly reviews to identify Decline-stage SKUs with remaining inventory and plan clearance actions,
while prioritizing Growth and Key products for revenue maximization.
- dm_sku_snapshot serves as the primary trigger source for operational workflows by providing the latest lifecycle, pricing, and inventory signals.
---

## 5. Relationship Between Data Marts
- dm_daily_sku supports **trend analysis and early signals**
- dm_sku_snapshot supports **current-state decisions**

Together, the two data marts provide both operational visibility
and strategic decision support.

---

## 6. Governance and Usage Notes
- Data marts are refreshed on a regular schedule.
- Business users may override pricing recommendations based on market conditions.
- All rule changes are reviewed and approved by Business and Production teams.

---

## 7. Limitations
- The data marts provide decision support but do not execute actions.
- Forecasting is based on explainable trend indicators rather than advanced predictive models.
