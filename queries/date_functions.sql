-- -- session 7 
-- Date Functions
-- Homework


--Total revenue by month
SELECT 
DATE_TRUNC('month',order_date_date) AS month,
SUM(total_sales) AS total_revenue
FROM sales_analysis
GROUP BY DATE_TRUNC('month',order_date_date)
ORDER BY total_revenue DESC;

--Total revenue by quarter
SELECT
DATE_TRUNC('quarter', order_date_date) AS quarter,
SUM(total_sales) AS total_revenue
FROM sales_analysis
GROUP BY DATE_TRUNC('quarter', order_date_date)
ORDER BY total_revenue DESC;


--Total revenue by year
SELECT
DATE_TRUNC('year', order_date_date) AS year,
SUM(total_sales) AS total_revenue
FROM sales_analysis
GROUP BY DATE_TRUNC('year', order_date_date)
ORDER BY total_revenue DESC;

--Comparing trends across different grains identify
SELECT 
DATE_TRUNC('month', order_date_date) AS month,
product_name,
SUM(total_sales) AS total_product_sales
FROM sales_analysis
GROUP BY DATE_TRUNC('month', order_date_date), product_name
ORDER BY total_product_sales DESC; 


--Strongest growth period by month
SELECT 
DATE_TRUNC('month', order_date_date) AS month,
SUM(total_sales) AS total_revenue
FROM sales_analysis
GROUP BY DATE_TRUNC('month', order_date_date)
ORDER BY total_revenue DESC
LIMIT 1;

--Weakest growt period by month
SELECT 
DATE_TRUNC('month', order_date_date) AS month,
SUM(total_sales) AS total_revenue
FROM sales_analysis
GROUP BY DATE_TRUNC('month', order_date_date)
ORDER BY total_revenue ASC
LIMIT 1;

--Customers activity
SELECT 
customer_name,
MAX(order_date) AS last_transaction_day,
(CURRENT_DATE - MAX(order_date)) AS past_time
FROM sales_analysis
GROUP BY customer_name;


--Using AGE() to describe customer recency in calendar terms
SELECT
customer_name,
MAX(order_date) AS last_transaction_date,
AGE(CURRENT_DATE, MAX(order_date)) AS customer_recency
FROM sales_analysis
GROUP BY customer_name;
