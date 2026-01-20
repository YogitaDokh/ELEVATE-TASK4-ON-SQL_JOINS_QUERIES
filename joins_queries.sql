/* =====================================================
   Northwind Database Joins Project
   Author: Yogita Dokh
   Date: 2026-01-20
   Description: SQL queries for customers, orders,
   products, categories with joins, aggregation, and
   business insights.
   ===================================================== */

/* =====================================================
   Dataset loading & key relationships verified
   ===================================================== */

/*
Primary Key - Foreign Key Mapping:
Customer.custId → SalesOrder.custId
SalesOrder.orderId → OrderDetail.orderId
Product.productId → OrderDetail.productId
Category.categoryId → Product.categoryId
*/


/* =====================================================
   INNER JOIN: Orders with Customer Details
   ===================================================== */

-- INNER JOIN query
SELECT 
    so.orderId,
    so.orderDate,
    c.custId,
    c.companyName,
    c.country
FROM SalesOrder so
INNER JOIN Customer c
    ON so.custId = c.custId;

-- Validation: Total orders before JOIN
SELECT COUNT(*) AS total_orders
FROM SalesOrder;

-- Validation: Total orders after JOIN
SELECT COUNT(*) AS joined_order_count
FROM SalesOrder so
INNER JOIN Customer c
    ON so.custId = c.custId;

/* =====================================================
   LEFT JOIN: Customers with No Orders
   ===================================================== */

SELECT 
    c.custId,
    c.companyName,
    c.country
FROM Customer c
LEFT JOIN SalesOrder so
    ON c.custId = so.custId
WHERE so.orderId IS NULL;

SELECT COUNT(*) AS customers_without_orders
FROM Customer c
LEFT JOIN SalesOrder so
    ON c.custId = so.custId
WHERE so.orderId IS NULL;

/* =====================================================
   Revenue Per Product (High-Performing SKUs)
   ===================================================== */

SELECT 
    p.productId,
    p.productName,
    SUM(od.unitPrice * od.quantity) AS totalRevenue
FROM OrderDetail od
INNER JOIN Product p
    ON od.productId = p.productId
GROUP BY p.productId, p.productName
ORDER BY totalRevenue DESC;

SELECT 
    p.productName,
    SUM(od.unitPrice * od.quantity) AS totalRevenue
FROM OrderDetail od
INNER JOIN Product p
    ON od.productId = p.productId
GROUP BY p.productName
ORDER BY totalRevenue DESC
LIMIT 5;

/* =====================================================
   Category-wise Revenue Distribution
   ===================================================== */

SELECT 
    cat.categoryId,
    cat.categoryName,
    SUM(od.unitPrice * od.quantity) AS categoryRevenue
FROM OrderDetail od
INNER JOIN Product p
    ON od.productId = p.productId
INNER JOIN Category cat
    ON p.categoryId = cat.categoryId
GROUP BY cat.categoryId, cat.categoryName
ORDER BY categoryRevenue DESC;

SELECT 
    cat.categoryName,
    ROUND(
        SUM(od.unitPrice * od.quantity) /
        (SELECT SUM(unitPrice * quantity) FROM OrderDetail) * 100,
        2
    ) AS revenuePercentage
FROM OrderDetail od
INNER JOIN Product p ON od.productId = p.productId
INNER JOIN Category cat ON p.categoryId = cat.categoryId
GROUP BY cat.categoryName
ORDER BY revenuePercentage DESC;

/* =====================================================
   Sales by Country and Date Range
   ===================================================== */

SELECT 
    c.country,
    DATE(so.orderDate) AS orderDate,
    SUM(od.unitPrice * od.quantity) AS totalSales
FROM SalesOrder so
INNER JOIN Customer c
    ON so.custId = c.custId
INNER JOIN OrderDetail od
    ON so.orderId = od.orderId
WHERE c.country = 'USA'
  AND so.orderDate BETWEEN '2007-01-01' AND '2007-12-31'
GROUP BY c.country, DATE(so.orderDate)
ORDER BY totalSales DESC;

SELECT 
    c.country,
    SUM(od.unitPrice * od.quantity) AS totalSales
FROM SalesOrder so
INNER JOIN Customer c ON so.custId = c.custId
INNER JOIN OrderDetail od ON so.orderId = od.orderId
WHERE c.country = 'USA'
  AND so.orderDate BETWEEN '2007-01-01' AND '2007-12-31'
GROUP BY c.country;

/* =====================================================
   Final Joined Output for CSV Export
   ===================================================== */

SELECT 
    so.orderId,
    so.orderDate,
    c.companyName,
    c.country,
    p.productName,
    cat.categoryName,
    od.quantity,
    od.unitPrice,
    (od.unitPrice * od.quantity) AS revenue
FROM SalesOrder so
INNER JOIN Customer c
    ON so.custId = c.custId
INNER JOIN OrderDetail od
    ON so.orderId = od.orderId
INNER JOIN Product p
    ON od.productId = p.productId
INNER JOIN Category cat
    ON p.categoryId = cat.categoryId;

