# Retail Product Lifecycle & Pricing Strategy

## 1. 📌Overview
This personal project analyzes retail sales and inventory data to support product lifecycle management, pricing strategy, inventory planning and operational decision-making.

The project is designed from a **Business Analyst (Retail / Operations)** perspective, focusing on business logic, data-driven insights and process improvement commonly applied in real retail environments.

---

## 2. 🔍Business Problems
Retail businesses often face:
- Static pricing applied across different product stages.
- Inventory imbalance causing stock shortages or excess stock.
- Slow operational and marketing response to sales trends.

---

## 3. 🎯Business Objectives
- Enable lifecycle-based pricing and inventory decisions.
- Reduce inventory risks through demand forecasting.
- Improve operational efficiency with automated workflows.

---

## 4. 🎯Scope
- In Scope: Product lifecycle classification, pricing strategy, demand forecasting, operational process improvements.  
- Out of Scope: Supplier negotiation, POS system integration.

---

## 5. ✍️Solution Summary
The solution classifies products by lifecycle and role to drive pricing, inventory and operational decisions.
It enables targeted pricing, demand forecasting and workflow automation reduce inventory risks and improve efficiency.

### Key solution components
🔁 Product Lifecycle Classification
- Products are classified into lifecycle stages (New, Growth, Maturity, Decline) based on sales trends, sales volume and product age.
- Lifecycle classification supports differentiated pricing and inventory strategies.

🔑 Key & Potential Product Identification
- In addition to lifecycle classification, products are further categorized into Key and Potential groups based on revenue contribution, sales performance, and growth signals.
- This classification enables targeted pricing, inventory and marketing actions.

💰 Pricing Strategy
- Pricing strategies are aligned with lifecycle stage and product role.

📈 Demand Forecasting & Restock Planning
- A simple demand forecasting approach is applied using historical sales trends.
- This helps reduce stockout and overstock risks.

🔁 Process Improvement & Workflow automation (Production Planning)

---

## 6. 🧩Deliverables
- [BRD](docs/business_requirements.md)
- [User Stories](docs/user_stories.md)
- [As-Is / To-Be Process](docs/AsIs_ToBe.drawio.png)
- [Wireframe / Prototype](figma-link)
- [UAT Summary](docs/UAT_Summary.md)
- [Lifecycle & Pricing Rules](docs/Lifecycle&Pricing_rules.md)

---
## 7. 📊 Data Sources
This project uses simulated omnichannel retail data generated for portfolio demonstration purposes. 
The datasets represent:
- Product master data
- Launch timing
- Sales transactions
- Inventory movements

---

## 8. 🛠 Tools & Technologies
- SQL for [Data cleaning](sql/01_cleaning.sql), [Quality checks](sql/02_quality_checks.sql), [Data integration](sql/03_integration.sql), [Data transformation](sql/04_transformation.sql), [Aggregations](sql/05_aggregation.sql)
- Python for forecasting logic prototyping
- Larksuite for workflows automation

---

## 9. 📌Business Insights & Recommendations
- Align pricing with product lifecycle to optimize revenue and margin.
- Focus inventory investment on Key and high-growth products.
- Use Potential products to experiment and scale demand.

---

## 10. 🚀Future Enhancements
- Enhance demand forecasting by incorporating seasonality and trend patterns.
- Provide BI dashboards for business monitoring.
- Enable data-driven marketing action recommendations.

