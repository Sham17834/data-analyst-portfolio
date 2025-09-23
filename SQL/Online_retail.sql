-- This SQL script is performing various analyses on the `Online Retail` table within the `sales`
-- database. Here is a breakdown of each section:

create database sales;
use sales;

-- 1. Calculate the total sales volume (excluding returns) and the average order value
SELECT
    ROUND(SUM(Quantity * UnitPrice), 2) AS TotalSalesRevenue,
    ROUND(AVG(Quantity * UnitPrice), 2) AS AverageOrderValue
FROM
    online_retail_data
WHERE
    Quantity > 0; -- Exclude returned orders (with a negative Quantity)
    
-- 2. To identify the country/region with the highest sales volume (excluding returns)
SELECT
    Country,
    ROUND(SUM(Quantity * UnitPrice), 2) AS TotalRevenueByCountry
FROM
    online_retail_data
WHERE
    Quantity > 0
GROUP BY
    Country
ORDER BY
    TotalRevenueByCountry DESC
LIMIT 5; -- Show the top 5 countries with the highest sales

-- 3. Calculate daily sales and sort by date
SELECT
    DATE(InvoiceDate) AS SaleDate, -- Extraction date section
    ROUND(SUM(Quantity * UnitPrice),2) AS DailySales
FROM
    online_retail_data
WHERE
    Quantity > 0
GROUP BY
    SaleDate
ORDER BY
    SaleDate ASC;
    
-- 4. To analyze the order quantity and total sales contribution of different customers (anonymous vs registered)
SELECT
    CASE
        WHEN CustomerID = -1 THEN 'Anonymous Customer' 
        ELSE 'Registered Customer'
    END AS CustomerType,
    COUNT(DISTINCT InvoiceNo) AS TotalOrders, -- Count the number of orders
    ROUND(SUM(Quantity * UnitPrice),2) AS TotalRevenue
FROM
    online_retail_data
WHERE
    Quantity > 0
GROUP BY
    CustomerType;

-- 5. To identify the Top 3 customers who purchase the largest quantity of goods
SELECT
    CustomerID,
    SUM(Quantity) AS TotalItemsPurchased
FROM
    online_retail_data
WHERE
    Quantity > 0 AND CustomerID != -1 -- Exclude returns and anonymous customers
GROUP BY
    CustomerID
ORDER BY
    TotalItemsPurchased DESC
LIMIT 3;