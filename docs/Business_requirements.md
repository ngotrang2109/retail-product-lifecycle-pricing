# Business Requirements Document (BRD)

## 1. Business Problem
The retail business operates across multiple sales channels (online, offline,
wholesale) with fast-moving products and frequent SKU launches.

Retail businesses face inventory imbalances (overstock/shortage) owing to:
- Inventory data fragmented between sales and warehouse systems.
- No single view of SKU performance across channels.
- Pricing not aligned with sales performance and product maturity.
- Lack of demand forecasting and slow operational reactions.

  These issues result in increased holding costs, lost sales opportunities and inefficient marketing spend.

This project aims to classify products by lifecycle, identify key products & potential products, and support pricing, restock strategy, and workflow improvements using data-driven analysis.

---

## 2. Business Objectives
- More consistent and explainable pricing decisions.
- Faster identification of slow-moving and high-potential SKUs.
- Reduce overstock and stockout risks through early inventory risk detection.
- Support timely restock planning using demand forecasting.
- Improve operational efficiency via workflow automation.

---

## 3. Key Stakeholders
- Production Operations Manager (Restock planning).
- Sales & Marketing Manager (Campaign and promotion planning).
- Retail Operations Manager (Pricing and inventory decisions).

---

## 4. Scope
In scope:
- Product lifecycle classification based on sales velocity and age.
- Pricing strategy mapping aligned with lifecycle stages.
- Daily and snapshot data mart to support operational decisions.
- Identification of key and potential products.
- Demand forecasting for restock planning.
- Process improvement and workflow automation for operational reaction.
  
Out of scope:
- Real-time system integration.
- Automated pricing execution.
- Automated production procurement execution.

---

## 5. Functional Requirements

- FR1: Product Lifecycle Classification

  The system shall classify products into lifecycle stages based on sales volume and product age.

- FR2: Pricing Strategy Recommendation

  The system shall recommend pricing actions (e.g. maintain price, promotion) based on the assigned lifecycle stage and sales performance.

- FR3: Inventory Risk Identification

  The system shall identify products with:
  - Low sales and high inventory (overstock risk)
  - High sales and low inventory (stockout risk)
    
- FR4: Key & Potential Product Identification

  The system shall identify:
  - Key Products: high sales contribution and stable demand.
  - Potential Products: emerging products with growth potential

- FR5: Demand Forecasting for Restock planning

  The system shall forecast product demand to support restock planning and reduce stockout risks.

- FR6: Operational Workflow automation

  The system shall trigger operational workflows based on product lifecycle classification and inventory risk to support timely restock actions.

---

## 6. Non-Functional Requirements
- Logic must be explainable and rule-based.
- Output must be easy to interpret by business users.
- Reports and dashboards should support decision-making without technical knowledge.

---

## 7. Assumptions
- Sales data is accurate and complete.
- Inventory levels are updated regularly.

---

## 8. Success Metrics (KPIs)
| FR  | KPI                                  | Measurement                    |
| --- | ------------------------------------ | ------------------------------ |
| FR1 | Lifecycle classification accuracy    | Rule consistency validation, Reduction in manual lifecycle overrides |
| FR2 | Pricing decision support speed       | Decision lead time from data refresh to recommendation availability, Reduction in manual analysis steps |
| FR3 | Inventory risk detection timing      | Risk detection timing |
| FR4 | Product prioritization effectiveness | Consistency of prioritized product list across teams |
| FR5 | Forecast reliability                 | Forecast vs actual sales trend comparison     |
| FR6 | Operational response efficiency      | Reduction in process steps, Decision turnaround time from insight to action |

---

## 9. Review & Governance
- Lifecycle and pricing rules are reviewed periodically
- Adjustments are made based on business performance and market conditions
- Final approval is owned by the Business and Pricing teams





