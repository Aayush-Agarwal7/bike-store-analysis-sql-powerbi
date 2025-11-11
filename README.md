# 🚴‍♂️ Bike Store Sales Insight Dashboard  

### *This project focuses on analyzing business performance and customer behavior across multiple bike retail stores*  

---

## 📑 Table of Contents  
1. [Overview](#overview)  
2. [Problem Statement](#problem-statement)  
3. [Dataset](#dataset)  
4. [Tools & Technologies](#tools--technologies)  
5. [Methods & Approach](#methods--approach)  
6. [Key Insights](#key-insights)  
7. [Dashboard](#dashboard)  
8. [Folder Structure](#folder-structure)  
9. [How to Run This Project](#how-to-run-this-project)  
10. [Result & Conclusion](#result--conclusion)  
11. [Author](#author)  

---

## 🧩 Overview  
This project analyzes the sales performance of a multi-store bike retailer using **MS SQL Server** and **Power BI**.  
It helps management monitor KPIs like revenue, order trends, and employee sales performance — providing a complete view of business growth and opportunities.  

---

## 💼 Problem Statement  
The bike store operates across multiple locations and product categories but lacked a unified, data-driven view of performance.  
Key questions included:  
- Which stores and cities generate the most revenue?  
- What product categories contribute the most to sales?  
- Who are the top-performing employees?  
- How do sales vary across time periods?  

This project bridges the gap between raw data and decision-making through SQL-based analysis and an interactive Power BI dashboard.  

---

## 📊 Dataset  

### 🔗 Sources  
- **Kaggle Dataset:** [Bike Store Relational Database](https://www.kaggle.com/datasets/dillonmyrick/bike-store-sample-database)  
- **Local Dataset:** Stored in the `data/` folder of this repository  

### 📁 Dataset Includes  
- **Orders:** Transaction details, revenue, and order dates  
- **Products:** Product and category information  
- **Customers:** Customer demographics and locations  
- **Employees:** Sales representative details  
- **Stores:** Branch and region data  

---

## 🧰 Tools & Technologies  
- 🧮 **MS SQL Server** – Data extraction, transformation, and analysis  
- 📊 **Power BI** – Data visualization and interactive dashboard creation  
- 🧠 **Kaggle Dataset** – Public relational database used for this project  
- 💻 **GitHub** – Version control and project documentation  

---

## ⚙️ Methods & Approach  
1. **Data Cleaning & Preparation**  
   - Imported relational tables into SQL Server  
   - Cleaned and standardized data (dates, product names, store codes)  

2. **SQL Analysis**  
   - Database creation and schema setup in SQL Server
   - Importing CSV data using T-SQL `BULK INSERT`
   - Data cleaning and constraint validation
   - Writing analysis queries to generate business insights:
   	1. Aggregations
   	2. Joins across schemas
   	3. Subqueries and CTEs
   	4. Window functions for ranking
   - Identified top-performing products, stores, and employees  

3. **Power BI Dashboard Creation**  
   - Built KPIs: Total Revenue, Total Orders, Average Order Value  
   - Designed visuals: Line charts, bar charts, and donut charts  
   - Added time filters (Last 12 months, Last 24 months, Overall)  

---

## 🔑 Key Insights  
- 💰 **Total Revenue:** \$7.69M from **1,615 orders**  
- 🛒 **Average Order Value (AOV):** \$4.76K per order  
- 🏙️ **Top Cities by Revenue:** Mount Vernon, Ballston Spa, San Angelo  
- 🚲 **Top Product Category:** Cruiser Bicycles (2,063 units sold)  
- 🏬 **Top Store:** Baldwin Bikes (67.83% of total revenue)  
- 👩‍💼 **Top Employees:** Marcel Boyer & Venita Daniel (\$2.6M each)  

---

## 📈 Dashboard  
![Bike Store Dashboard](images/Bike%20Store%20Sales%20Insight%20Dashboard.PNG)  

**Dashboard Features:**  
- Monthly Revenue Trend (2016–2018)  
- KPIs for Revenue, Orders, and AOV  
- Top 5 Cities by Revenue  
- Top Categories by Unit Sold  
- Store Revenue Contribution  
- Employee Performance by Sales  

---

## 🗂️ Folder Structure  

```

bike-store-sql-powerbi-analysis/
│
├── data/ # Contains all CSV dataset files
│
├── SQL Script/ # SQL scripts for database setup and analysis
│ ├── import_data.sql # Creates database, schema & performs bulk inserts
│ └── analysis_queries.sql # Contains all SQL analysis queries
│
├── Query Result/ # Stores all SQL query result exports
│
├── dashboard/ # Power BI dashboard files
│ └── bike_store_analysis.pbix
│
├── images/ # Power BI dashboard screenshots
│ └── Bike Store Sales Insight Dashboard.PNG
│
└── README.md # Project documentation
```
---

## 🧭 How to Run This Project  

1. **Clone the Repository**
   ```bash
   git clone https://github.com/Aayush-Agarwal7/bike-store-analysis-sql-powerbi.git

2. Set Up the Database

	- Open import_data.sql in MS SQL Server

	- Run the script to create the database, schema, and bulk insert data from the /data folder

3. Run Analysis Queries

	- Execute analysis_queries.sql to generate summary tables and insights

4. Open the Power BI Dashboard

	- Open bike_store_analysis.pbix in Power BI

	- Connect to your local SQL Server if needed

	- Refresh the dataset to update visuals

## 🏁 Result & Conclusion

The analysis and dashboard provide a comprehensive view of sales across stores, products, and employees.
Management can now:

	 Track sales performance by city and store

	 Identify seasonal revenue trends

	 Recognize top-performing employees

	 Optimize product stocking and marketing

### This project demonstrates how combining SQL and Power BI can turn raw data into strategic business insights.

## 👤 Author

**Aayush Agarwal**


Role: Data Analyst | SQL & Power BI 


LinkedIn: [https://www.linkedin.com/in/aayush-agarwal-17b1a814b/]


Email: aayushagarwal0705@gmail.com



