# Northwind SQL Joins Analysis

## Project Overview
This project demonstrates advanced SQL joins and data analysis using the **Northwind database**. It covers inner joins, left joins, aggregation, and conditional queries to generate business insights from customers, orders, products, and categories.

## Dataset
- **Customers:** 91 records  
- **Products:** 77 records  
- **Sales Orders:** 830 records  
- **Order Details:** 2,155+ records  
- **Categories:** 8 records  

All tables are normalized with proper **Primary Keys (PK)** and **Foreign Keys (FK)** to ensure referential integrity.

**Note:** This project uses the publicly available Northwind database. The MySQL version can be downloaded here: [Northwind MySQL SQL](https://github.com/harryho/db-samples/blob/master/mysql/northwind.sql).  

Run the SQL file in MySQL Workbench to create tables and populate data before executing the queries in `joins_queries.sql`.

## Key Relationships
- `Customer.custId → SalesOrder.custId`  
- `SalesOrder.orderId → OrderDetail.orderId`  
- `Product.productId → OrderDetail.productId`  
- `Category.categoryId → Product.categoryId`  

These relationships enable accurate joins and aggregate analysis.

## Deliverables
1. `joins_queries.sql` – Complete SQL queries with comments  
2. `joined_output.csv` – Final joined dataset combining customers, orders, products, and categories  
3. `insights.txt` – Three business insights derived from the analysis

## SQL Techniques Used
- **INNER JOIN:** Combine orders with customer details and product info  
- **LEFT JOIN:** Identify customers with no orders  
- **Aggregations:** SUM to calculate revenue per product and category  
- **Filtering:** WHERE clause for country and date-based analysis  
- **Aliases:** c, so, od, p, cat for readability and scalability  

## Business Insights
1. A small number of top-performing products generate a disproportionate share of total sales, reflecting a strong Pareto (80/20) effect.  
2. Certain product categories dominate overall revenue, guiding inventory planning and promotional strategies.  
3. Customers with no recorded orders present opportunities for targeted marketing and reactivation campaigns to boost conversions.

## How to Use
1. Open `joins_queries.sql` in MySQL Workbench.  
2. Run queries step by step or export the final joined output to CSV.  
3. Analyze `joined_output.csv` or use it in BI tools for dashboards and reporting.

## Author
**Yogita Dokh** – SQL & Data Analysis Project

---

