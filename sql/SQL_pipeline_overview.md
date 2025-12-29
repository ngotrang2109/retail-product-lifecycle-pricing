# SQL Pipeline Overview

_Product Lifecycle & Pricing Strategy Project_

---

## 1. Purpose of This Document

This document explains how SQL is organized and used in this project to support
business analysis for **Product Lifecycle Classification** and **Pricing Strategy Design**.

The SQL scripts are structured as a **data pipeline**, where each stage aligns with
specific business objectives and functional requirements, rather than technical implementation details.

This separation allows:

- Business stakeholders to validate logic at a conceptual level
- Technical reviewers to understand data flow and transformations
- Clear traceability from business rules to data outputs

---

## 2. High-Level Pipeline Structure

Raw data -> Cleaning & Standardization -> Data Quality Checks -> Multi-source Integration -> Business Transformation -> Aggregation & Analytics Mart

Each stage is implemented as a separate SQL script to improve clarity,
maintainability, and validation.

---

## 3. Pipeline Stages Description

### 3.1 Cleaning & Standardization (`01_cleaning.sql`)

**Business Objective**  
Ensure consistent and reliable base data before applying any analytics logic.

**Key Activities**

- Standardize SKU codes across all data sources
- Normalize date formats
- Remove obvious invalid records (null SKU, negative quantities)

**Business Rationale**  
Inconsistent SKU formats and dirty transactional data can lead to double counting
and incorrect lifecycle classification.

---

### 3.2 Data Quality Checks (`02_quality_checks.sql`)

**Business Objective**  
Detect data issues early that may affect decision-making quality.

**Key Checks**

- Orphan SKUs (transactions without product master reference)
- Abnormal inventory movements
- Duplicate daily transactions

**Business Rationale**  
Lifecycle and pricing decisions must be based on trusted data.  
These checks help identify risks before insights are consumed by business users.

---

### 3.3 Multi-source Integration (`03_integration.sql`)

**Business Objective**  
Create a unified view of sales and inventory across all channels.

**Key Activities**

- Combine online sales, offline POS, wholesale, and inventory movements
- Use full joins to avoid losing transactions from any channel
- Consolidate data at the daily SKU level

**Business Rationale**  
Merchandising and pricing decisions require a holistic view of product performance,
not isolated channel reports.

---

### 3.4 Business Transformation (`04_transformation.sql`)

**Business Objective**  
Translate raw data into meaningful business insights and decision-support metrics.

**Key Transformations**

- Inventory balance calculation
- SKU age and lifecycle classification
- Sales velocity and performance evaluation
- Pricing strategy mapping by lifecycle stage

**Business Rationale**  
This stage implements the core business rules that drive lifecycle-based pricing
and inventory strategies.

---

### 3.5 Aggregation & Analytics Mart (`05_aggregation.sql`)

**Business Objective**  
Provide simplified, decision-ready datasets for analysis and reporting.

**Key Outputs**

- Daily SKU performance fact table
- SKU lifecycle snapshot by batch/launch
- Inventory risk and stock-out indicators

**Business Rationale**  
Aggregated views reduce complexity for business users and enable faster,
more consistent decision-making.

---

## 4. Relationship to Business Requirements

| Business Requirement            | Pipeline Stage               |
| ------------------------------- | ---------------------------- |
| Lifecycle classification        | Transformation               |
| Pricing strategy recommendation | Transformation               |
| Inventory risk identification   | Transformation & Aggregation |
| Performance monitoring          | Aggregation                  |

This structure ensures traceability from business requirements to data outputs.

---

## 5. Design Principles

- **Business-first logic**: SQL reflects business rules, not just calculations
- **Separation of concerns**: Cleaning, validation, and analytics are isolated
- **Explainability**: Each stage can be reviewed independently
- **Scalability**: New rules or data sources can be added without refactoring the entire pipeline

---

## 6. Notes for Reviewers

- SQL is intentionally organized by pipeline stage for readability
- Detailed SQL logic is secondary to business rule clarity
- This project prioritizes explainability and validation over technical optimization
- Raw data used in this pipeline is generated via Python scripts to simulate
  real-world retail systems (product master, orders, bills, inventory movements).
- The SQL pipeline is executed locally using DuckDB by loading these raw CSV files
  and applying staged transformations.

For business context and decision logic, please refer to the main project README.
