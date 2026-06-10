# 🌍 Global Supply Chain & Sales Analytics: End-to-End Data Project

![Uploading dashboard.png.png…]()

## 📌 Project Overview

This project is a comprehensive, end-to-end data analytics and business intelligence solution. It simulates a real-world data engineering environment where raw, unstructured data is transformed into actionable strategic insights. The project covers the entire data lifecycle: Schema Optimization, Data Cleaning (SQL), Exploratory Data Analysis (SQL & Python), and Data Visualization (Power BI & Figma).

The primary objective is to provide executive management with data-driven insights to optimize logistics, inventory, marketing budgets, and sales strategies.

## 🛠️ Tech Stack & Tools

* **Database Management:** MySQL Server 8.0
* **Data Engineering & Analysis:** Advanced SQL (Window Functions, CTEs, Time-Intelligence)
* **Python for Data Science:** Pandas, SQLAlchemy (Database Connection), Matplotlib, Seaborn
* **Business Intelligence:** Power BI Desktop (DAX, Power Query, Star Schema)
* **UI/UX Design:** Figma (Custom Dashboard Layouts)

## 📂 Repository Structure & Workflow

### 1️⃣ Database Schema Optimization (`01_raw_schema_optimization.sql`)
Before analyzing the data, the raw database schema was optimized to ensure memory efficiency and calculation accuracy.
* Altered column data types to appropriate formats (`DECIMAL` for financial metrics, `INT` for quantities, `VARCHAR` for categorical data).

### 2️⃣ Data Cleaning & Transformation (`02_data_cleaning.sql`)
Rigorous data quality checks and transformations were applied using SQL:
* **Time-Intelligence Readiness:** Converted raw string dates into standardized MySQL `DATETIME` formats using `STR_TO_DATE()`.
* **Duplicate Removal:** Identified and permanently deleted exactly 20,756 duplicate rows using advanced Window Functions (`ROW_NUMBER()` with `PARTITION BY`).
* **Handling Missing Values:** Replaced `NULL` values in customer names with 'Unknown' and dropped entirely empty columns (`Product_Description`) to reduce database size. Strategically kept `NULL`s in Zipcodes to protect sales data integrity.
* **Anomaly Detection:** Checked for outliers and system billing errors (ensuring `Order_Item_Total` did not exceed `Sales`).
* **Feature Engineering:** Extracted `Order_Year`, `Order_Month`, and `Order_Day_Name` for faster time-series reporting.

### 3️⃣ Exploratory Data Analysis (EDA) & Business Logic (`03_exploratory_data_analysis.sql`)
Developed complex SQL queries to extract key performance indicators (KPIs) and business insights:
* **Profitability Analysis:** Identified top revenue-generating categories vs. top profit-margin categories (Identifying profit bleeding).
* **Temporal Trends:** Analyzed yearly, monthly (seasonality), and daily sales/profit trends.
* **Customer Behavior:** Evaluated preferred payment methods and top-performing global regions.

### 4️⃣ Python Seasonal Trend Analysis (`monthly_sales_trends.py`)
* Integrated Python into the workflow to fetch data directly from the MySQL database using SQLAlchemy.
* Utilized Pandas for data grouping and aggregation.
* Leveraged Seaborn and Matplotlib to build programmatic visualizations highlighting seasonal sales peaks to inform Safety Stock decisions.

### 5️⃣ Power BI Dashboard & Visualizations
* Connected the cleaned and modeled data (Star Schema) to Power BI.
* Created dynamic DAX measures for real-time tracking.
* Designed a custom, visually appealing user interface using Figma to escape generic BI templates and provide a professional executive summary.

## 💡 Key Strategic Insights

* **The Profit Paradox:** While "Fishing" leads in total revenue ($6.1M), the "Golf Bags & Carts" category holds the highest profit margin (17.46%). Marketing budgets should be reallocated to support these high-margin items.
* **Logistics Bottleneck (54.88% Late Delivery):** Internal processing is highly efficient (Avg Lead Time: 3.5 Days). The high late delivery rate is an external issue caused by third-party shipping carriers, demanding immediate contract renegotiations.
* **Inventory Gaps (Lost Revenue):** An order fulfillment rate of 45.12% highlights severe stockouts.
* **Seasonality & Safety Stock:** Python and SQL analysis revealed significant sales volatility between October and December. The company must implement a "Safety Stock" strategy prior to Q4 to handle peak demand.
* **Payment Security:** Over 65% of transactions rely on Debit and Bank Transfers, making the stability of digital payment gateways a top organizational priority.

## 🚀 How to Run the Project

1. Clone this repository.
2. Execute `01_raw_schema_optimization.sql` followed by `02_data_cleaning.sql` in your MySQL environment.
3. Run `03_exploratory_data_analysis.sql` to verify the business metrics and KPIs.
4. Execute `monthly_sales_trends.py` to view the Python-generated seasonality plots (ensure you update your database credentials in the script).
5. Open the Power BI `.pbix` file to interact with the final dashboard.
6. Review the full business documentation in the attached PDF portfolio.

---

## 👨‍💻 Let's Connect!

**Mohamed Talaat** | *Data Analyst & Machine Learning Enthusiast*

* **Email:** mohamed.talat.data@gmail.com
* **LinkedIn:** [Mohamed Talaat](https://www.linkedin.com/in/mohamed-talaat-64756a400)
