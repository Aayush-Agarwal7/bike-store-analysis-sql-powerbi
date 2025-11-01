# Bike Store SQL Analysis Project

A SQL-based analysis of retail performance using the Bike Store sample relational database from Kaggle.

---

## Overview
This project focuses on analyzing business performance and customer behavior across multiple bike retail stores. The objective is to demonstrate strong SQL skills through end-to-end database setup, data import, and analytical querying with Microsoft SQL Server.

---

## Problem Statement
Retail managers require insights into product demand, store performance, sales trends, and inventory levels. The goal is to answer key business questions such as:
- Which stores generate the highest revenue?
- Which products and brands drive profitability?
- What is the sales trend over time?
- Where does inventory require optimization?
- Who are the most valuable customers?

---

## Dataset
**Source:** Kaggle  
Bike Store Sample Database  
Link: https://www.kaggle.com/datasets/dillonmyrick/bike-store-sample-database

**Data includes:**
- Products and categories
- Brands
- Customers and stores
- Staff and orders details
- Inventory (stock levels)

**File formats:** CSV  
**Database used:** Microsoft SQL Server

---

## Tools and Technologies
| Category | Tools |
|---------|------|
| Database | Microsoft SQL Server (T-SQL) |
| Query Tool | SQL Server Management Studio (SSMS) |
| Version Control | Git, GitHub |
| Optional Data Visualization | Excel or Power BI (if results exported) |

---

## Methods
The following approach was used:
1. Database creation and schema setup in SQL Server
2. Importing CSV data using T-SQL `BULK INSERT`
3. Data cleaning and constraint validation
4. Writing analysis queries to generate business insights:
   - Aggregations
   - Joins across schemas
   - Subqueries and CTEs
   - Window functions for ranking
5. Exporting and documenting insights for stakeholders

---

## Key Insights (examples)
- Store performance varies significantly; online demand peaks in certain regions.
- Top-selling products belong to premium brand categories.
- A small percentage of high-value customers drive majority sales.
- Inventory imbalance identified in low-turnover items.
- Sales performance increases seasonally across bikes and accessories.

*(Your actual results may adjust once queries are finalized and exported.)*

---

## Output (Queries / Results / Dashboard)
- `sql/analysis_queries.sql` contains all business questions and SQL queries with comments.
- Optional visual outputs included in `results/` folder such as:
  - Top 10 revenue products table
  - Monthly sales trend analysis
  - Store performance comparison

If you build a Power BI dashboard later, screenshots can also be added here.

---

## How to Run This Project

### Prerequisites
- Windows system with Microsoft SQL Server or SQL Server Express installed
- SQL Server Management Studio (SSMS)
- Git installed locally

### Steps
1. Clone the repository:
   ```bash
   git clone https://github.com/<your-username>/bike-store-sql-analysis.git
   cd bike-store-sql-analysis
