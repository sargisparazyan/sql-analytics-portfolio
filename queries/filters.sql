-- =========================================
-- filters.sql
-- SQL Analytics Portfolio
-- Description: Transaction segmentation and filtering queries
-- =========================================

-- Task 1 | Complex Transaction Segmentation (CASE + WHERE)
SELECT 
discount,
city,
category,
total_sales,
CASE 
    WHEN total_sales >= 499 
	AND discount <= 0.04
	AND category = 'Electronics' 
	THEN 'High-value transactions with low discount'
	WHEN total_sales BETWEEN 300 AND 499
	AND discount > 0.04 AND discount <= 0.30
	THEN 'Medium-value transactions with moderate discount'
	WHEN total_sales < 300
	OR discount BETWEEN 0.30 AND 0.50
	THEN 'Low-value or heavily discounted transactions'
	WHEN category = 'Books' AND city = 'Osborneside'
	THEN 'Unique transactions'
	ELSE 'Other transactions'
END AS Transaction_segment
FROM sales_analysis
WHERE year = '2023';




-- Task 2 | Category-Level Performance Analysis (CASE + GROUP BY + HAVING)
SELECT 
category,
SUM(total_sales) AS total_sales,
COUNT(transaction_id) AS transaction_count,
AVG(discount) AS avg_discount,
CASE
     WHEN SUM(total_sales) > 499
AND AVG(discount) < 0.04
	 THEN 'Strong performer'
	 WHEN SUM(total_sales) BETWEEN 250 AND 499
	 AND AVG(discount) >= 0.04 AND  AVG(discount) <= 0.50
	 THEN 'Average performer'
	 WHEN COUNT(transaction_id) <= 10
	 OR AVG(discount) > 0.50
	 THEN 'Underperformer'
	 ELSE 'Others'
	 END AS category_level
	 FROM sales_analysis
	 WHERE year = 2023
	 GROUP BY category
	 HAVING COUNT(transaction_id) >= 4
	 ORDER BY SUM(total_sales) DESC;



-- Task 3 | City-Level Activity Analysis (COUNT + HAVING + CASE)
SELECT
city, 
COUNT(transaction_id) AS transaction_count,
CASE
    WHEN COUNT(transaction_id) >= 5
	THEN 'High Activity'
	WHEN COUNT(transaction_id) BETWEEN 3 AND 5
	THEN 'Medium Activity'
	ELSE 'Low Activity'
	END AS activity_level
	FROM sales_analysis
	WHERE year = 2023
	GROUP BY city
	HAVING COUNT(*) <= 5
	ORDER BY transaction_count DESC;



-- Task 4 | Discount Behavior Analysis (CASE + HAVING)
SELECT
category,
AVG(discount) AS avg_discount,
SUM(total_sales) AS total_sales,
CASE 
    WHEN AVG(discount) >= 0.40
	THEN 'Discount-Heavy'
	WHEN AVG(discount) BETWEEN 0.20 AND 0.40
	THEN 'Moderate Discount'
	ELSE 'Low or No Discount'
	END AS Discount_Level
	FROM sales_analysis
	WHERE year = 2023
	GROUP BY category
	HAVING COUNT(*) > 5
	ORDER BY avg_discount DESC;