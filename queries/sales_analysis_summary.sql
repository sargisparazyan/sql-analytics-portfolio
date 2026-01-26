-- -- session 5
-- -- Homework Task

-- --1.1) total_revenue of company
SELECT
SUM(total_sales) AS total_revenue
FROM sales_analysis


-- --1.2) total_revenue by category 

SELECT
category,
SUM(total_sales) AS total_revenue
FROM sales_analysis
GROUP BY category

-- --1.3) max total_revenue by category

SELECT
category,
SUM(total_sales) AS total_revenue
FROM sales_analysis
GROUP BY category
ORDER BY total_revenue DESC

 --2) avg vs median by total_sales
SELECT 
AVG(total_sales) AS avg_transaction_value,
PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY total_sales) AS median_transaction_value
FROM sales_analysis


--3.1) NULL discount check
SELECT 
COUNT(*) AS discount_null
FROM sales_analysis
WHERE discount IS NULL;

--3.2) average of discount by defaault
SELECT
AVG(discount) AS average_discount_default
FROM sales_analysis

--3.3) by zero imputation
SELECT
AVG(COALESCE(discount, 0)) AS avg_discount_zero_imputed
FROM sales_analysis

--3.4) by average imputation
WITH avg_val AS(
SELECT
AVG(discount) AS avg_discount
FROM sales_analysis
)
SELECT
AVG(COALESCE(discount, avg_discount)) AS avg_discount_average_imputed
FROM sales_analysis, avg_val; 


--3.5) by median imputation
WITH avg_val AS(
SELECT
PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY discount) AS median_discount
FROM sales_analysis
)
SELECT
AVG(COALESCE(discount, median_discount)) AS avg_discount_median_imputed
FROM sales_analysis, avg_val;

--4.1) group transactions into 50-unit revenue ranges

SELECT
    FLOOR(total_sales / 50) * 50 AS revenue_range_start,
    COUNT(*) AS transactions_count,
    SUM(total_sales) AS total_revenue
FROM sales_analysis
GROUP BY FLOOR(total_sales / 50) * 50
ORDER BY revenue_range_start;

--4.2) dominant range by transactions_count

SELECT
    FLOOR(total_sales / 50) * 50 AS revenue_range_start,
    COUNT(*) AS transactions_count,
    SUM(total_sales) AS total_revenue
FROM sales_analysis
GROUP BY FLOOR(total_sales / 50) * 50
ORDER BY transactions_count DESC
LIMIT 1


--5) checking transaction dublicates
SELECT
transaction_id,
COUNT(*) as dublicate_count
FROM sales_analysis
GROUP BY transaction_id
HAVING COUNT(*) > 1
