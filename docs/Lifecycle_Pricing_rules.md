# Lifecycle & Pricing Rules

## 1. Purpose
This document defines the business rules used to:
- Classify products into lifecycle stages
- Identify Key and Potential products
- Apply pricing strategies aligned with lifecycle stage and product role
  
These rules support pricing optimization, inventory management and operational decision-making.

---

## 2. Inputs & Data Considerations
The following data is used as input for lifecycle and pricing decisions:
- Historical sales volume
- Revenue contribution
- Sales growth trend
- Product age (time since launch)
- Current inventory level
  
(Specific calculation methods are defined in the system design and are not covered in this document.)

---

## 3. Product Lifecycle Classification Rules
### 3.1 Lifecycle Stages
Products are classified into one of the following lifecycle stages:
- New
- Growth
- Maturity
- Decline
  
### 3.2 Lifecycle Classification Logic (High-level)
Criteria	Description
- Sales Volume:	Absolute sales performance over recent periods
- Sales Trend:	Increasing, stable or declining trend
- Product Age:	Time since product launch
  
General classification principles:
- New: Newly launched products
- Growth: Products showing strong and increasing sales performance.
- Maturity: Products with high and stable sales, indicating market saturation.
- Decline: Products experiencing consistent sales decline.

Lifecycle classification is reviewed on a regular basis to reflect changes in sales performance.

Not all products will experience all lifecycle stages. Lifecycle classification is rule-based and products may skip stages depending on sales performance and demand signals
---

## 4. Product Role Identification Rules
### 4.1 Product Roles
In addition to lifecycle stage, products are categorized into business roles:
- Key Products
- Potential Products
- Other Products
  
### 4.2 Product Role Logic
Role	Business Characteristics
- Key Products:	High sales volume and stable performance (core revenue and traffic drivers).
- Potential Products:	Products showing positive growth signals with opportunities for scaling.
- Other Products
  
Product roles are used to prioritize pricing, inventory and marketing actions.

---

## 5. Pricing Strategy Rules
Pricing strategies are determined by the combination of:
- Product lifecycle stage
- Product role
  
### Pricing Strategy by Lifecycle & Role
|Lifecycle Stage |Product Role |Pricing Strategy |Business actions |
|------|----------|------------------|-------------------------------|
|New	|Any	|Entry-level pricing |Test market response with controlled SKU investment |
|Growth	|Key	|Maintain price stability |Maximize revenue and ensure product availability |
|Growth	|Potential	|Controlled promotional pricing |Increase volume and upgrade to Key status |
|Growth	|Other	|Selective promotions |Support sales with limited investment |
|Maturity	|Key	|Optimize pricing |Protect margin and defend market position |
|Maturity	|Potential	|Tactical promotions |Stimulate repeat purchase and delay decline |
|Maturity	|Other	|Competitive pricing |Maintain presence with minimal investment |
|Decline	|Any	|Clearance pricing |Reduce inventory and minimize holding cost |

---

## 6. Inventory & Operational Impact
Lifecycle and pricing rules enable the following operational actions:
- Early identification of overstock and stockout risks.
- Prioritization of restock planing and marketing budget for Key and Potential products.
- Triggering production or marketing actions based on demand signals.

---

## 7. Review & Governance
- Lifecycle and pricing rules are reviewed periodically
- Adjustments are made based on business performance and market conditions
- Final approval is owned by the Business and Pricing teams
