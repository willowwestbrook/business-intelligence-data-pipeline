# Business Intelligence Data Pipeline

End-to-end BI pipeline project covering relational data modeling, advanced SQL analytics, Power Pivot integration, and Power BI dashboard reporting. Work spans two databases — a Northwind-style sales database and the Dillards retail database — demonstrating the full workflow from raw data to business insights.

---

## Skills Demonstrated

- **SQL** — CTEs, window functions (LAG, RANK), multi-table joins, aggregations, and profit calculations across two distinct relational databases
- **Power BI** — Dashboard design and report building with multi-dimensional business metrics
- **Power Pivot** — Multi-table data modeling and relationship management within Excel
- **ERD Design** — Entity-relationship diagram creation for documenting database schema
- **Data Export & Transformation** — Structured query output exported to CSV for downstream reporting

---

## Repository Contents

| File | Description |
|------|-------------|
| `sql/northwind_sales_analysis.sql` | Monthly revenue and quantity trends with month-over-month change using LAG; top 3 products ranked by annual revenue using RANK |
| `sql/dillards_retail_analysis.sql` | Revenue and profit analysis by city, store, brand, and department across the Dillards retail database |
| `outputs/northwind_monthly_revenue.csv` | Query results: product-level monthly revenue with percentage change |
| `outputs/northwind_top_products.csv` | Query results: top 3 products by annual revenue per year |
| `outputs/dillards_store_dept_brand_profit.csv` | Query results: profit breakdown by store, department, and brand |
| `visuals/dillards_erd.png` | Entity-relationship diagram for the Dillards database schema |
| `visuals/power_bi_dashboard.pdf` | Exported Power BI dashboard with multi-metric retail reporting |
| `docs/power_pivot_multi_table_guide.docx` | Reference guide for building multi-table models in Power Pivot |
| `docs/dillards_fact_data.tflx` | Tableau data source file for the Dillards fact table |

---

## SQL Highlights

### Northwind — Month-over-Month Revenue Analysis
Uses a two-stage CTE to calculate monthly revenue per product, then applies `LAG()` to compare against the prior month and compute percentage change.

### Northwind — Annual Product Rankings
Uses `RANK()` partitioned by year to identify the top 3 revenue-generating products for each calendar year.

### Dillards — Multi-Dimensional Profitability
Calculates profit as `(ORGPRICE - SPRICE) * QUANTITY` across multiple grouping dimensions — brand, store, city, state, and department — using multi-table joins across transaction, store, SKU, and department tables.

---

## Tools & Technologies

`SQL` `Power BI` `Power Pivot` `Excel` `Tableau` `ERD Design` `CSV Data Export`

---

## About This Repository

This repository is part of a broader data and analytics portfolio. The work here reflects applied skills in end-to-end BI workflows directly relevant to roles in:

- Data Analysis
- Business Intelligence Engineering
- Data Engineering
- Business Analysis
- Enterprise Reporting & Analytics
