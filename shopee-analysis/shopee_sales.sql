select * from shopee_sales;

-- Top 10 Best-Selling Products
SELECT 
    subcategory_1 AS product,
    SUM(total_sold) AS total_units_sold
FROM shopee_sales
GROUP BY subcategory_1
ORDER BY total_units_sold DESC
LIMIT 10;

-- Total Sales by Main Category
SELECT 
    main_category,
    SUM(total_sold) AS total_units_sold
FROM shopee_sales
GROUP BY main_category
ORDER BY total_units_sold DESC;

-- Average Rating by Main Category
SELECT 
    main_category,
    ROUND(AVG(item_rating), 2) AS avg_rating,
    COUNT(*) AS num_products
FROM shopee_sales
WHERE item_rating IS NOT NULL
GROUP BY main_category
ORDER BY avg_rating DESC
LIMIT 10;

-- Monthly Sales Trend
SELECT 
    w_date AS month,
    SUM(total_sold) AS total_units_sold
FROM shopee_sales
GROUP BY month
ORDER BY month;

-- Sales in 2023
SELECT 
    w_date AS month,
    SUM(total_sold) AS total_units_sold
FROM shopee_sales
WHERE w_date >= '1/1/2023' AND w_date <= '31/12/2023'
GROUP BY month
ORDER BY total_units_sold;

-- Top 10 Sellers by Total Sales
SELECT 
    seller_name,
    SUM(total_sold) AS total_units_sold
FROM shopee_sales
GROUP BY seller_name
ORDER BY total_units_sold DESC
LIMIT 10;

-- Average Price by Main Category
SELECT 
    main_category,
    ROUND(AVG(price_actual), 2) AS avg_price
FROM shopee_sales
WHERE price_actual IS NOT NULL
GROUP BY main_category
ORDER BY avg_price DESC
LIMIT 10;

-- Products with High Favorites
SELECT 
    subcategory_1 AS product,
    SUM(favorite) AS total_favorites
FROM shopee_sales
GROUP BY subcategory_1
ORDER BY total_favorites DESC
LIMIT 10;

-- Sales by Price Range
SELECT 
    CASE 
        WHEN price_actual BETWEEN 0 AND 50 THEN '0-50'
        WHEN price_actual BETWEEN 51 AND 100 THEN '51-100'
        WHEN price_actual BETWEEN 101 AND 500 THEN '101-500'
        ELSE '500+'
    END AS price_range,
    SUM(total_sold) AS total_units_sold
FROM shopee_sales
GROUP BY price_range;

-- Sellers with Highest Average Ratings
SELECT 
    seller_name,
    ROUND(AVG(item_rating), 2) AS avg_rating,
    COUNT(*) AS num_products
FROM shopee_sales
WHERE item_rating IS NOT NULL
GROUP BY seller_name
ORDER BY avg_rating DESC
LIMIT 10;

-- Total Sales by Subcategory Level 2
SELECT 
    subcategory_2,
    SUM(total_sold) AS total_units_sold
FROM shopee_sales
GROUP BY subcategory_2
ORDER BY total_units_sold DESC
LIMIT 10;

-- Correlation Between Price and Sales
SELECT 
    ROUND(AVG(price_actual), 2) AS avg_price,
    SUM(total_sold) AS total_units_sold
FROM shopee_sales
GROUP BY FLOOR(price_actual / 50) * 50
ORDER BY avg_price
limit 10;

-- Top 5 Categories by Total Rating Count
SELECT 
    main_category,
    SUM(total_rating) AS total_rating_count
FROM shopee_sales
GROUP BY main_category
ORDER BY total_rating_count DESC
LIMIT 5;

-- Daily Sales Peak in 2023
SELECT 
    w_date,
    SUM(total_sold) AS total_units_sold
FROM shopee_sales
WHERE w_date >= '1/1/2023' AND w_date <= '31/12/2023'
GROUP BY w_date
ORDER BY total_units_sold DESC
LIMIT 1;

