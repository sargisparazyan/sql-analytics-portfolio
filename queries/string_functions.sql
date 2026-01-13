--===================================================
--string_functions.sql
--SQL Analytics Portfolio
-- Description: Text Data Profiling, Standardization, and KPI Impact Analysis
--===================================================


--Session 6 - Part 1 
--Profiling

SELECT
raw_phone,
LENGTH(raw_phone) AS phone_length,
COUNT(*) AS occurrences
FROM transactions_text_demo
GROUP BY raw_phone, LENGTH(raw_phone)
ORDER BY occurrences DESC;

SELECT
  COUNT(DISTINCT raw_phone) AS distinct_raw_phones
FROM transactions_text_demo;

SELECT
category_raw,
COUNT(*) AS transactions
FROM transactions_text_demo
GROUP BY category_raw
ORDER BY transactions DESC;


SELECT
  COUNT(DISTINCT category_raw) AS distinct_raw_categories
FROM transactions_text_demo;








-- Session 6 - Part 2
--Standardization Layer
SELECT
    transaction_id,
    SUBSTRING(
        REGEXP_REPLACE(raw_phone, '[^0-9]', '', 'g')
        FROM LENGTH(REGEXP_REPLACE(raw_phone, '[^0-9]', '', 'g')) - 7 FOR 8
    ) AS phone_clean,
    TRIM(REGEXP_REPLACE(category_raw, '\([^)]*\)', '', 'g')) AS category_clean,
    quantity * price AS revenue_per_transaction
FROM transactions_text_demo;



--Session 6 - Part 3 KPI comparison
-- Not cleaned
SELECT
category_raw,
raw_phone,
SUM(quantity*price) AS  revenue_raw
FROM transactions_text_demo
GROUP BY category_raw, raw_phone
ORDER BY revenue_raw DESC;


-- Cleaned
SELECT
TRIM(REGEXP_REPLACE(category_raw, '\([^)]*\)', '', 'g')) AS category_clean,
  SUBSTRING(
        REGEXP_REPLACE(raw_phone, '[^0-9]', '', 'g')
        FROM LENGTH(REGEXP_REPLACE(raw_phone, '[^0-9]', '', 'g')) - 7 FOR 8
    ) AS phone_clean,
	SUM(quantity*price) AS revenue_raw_clean
	FROM transactions_text_demo
	GROUP BY category_clean, phone_clean
	ORDER BY revenue_raw_clean DESC;


-- Session 6 - Part 4  Analytical Explanation 
-- KPI Summary 

-- KPIs changed due to non-standardized phone numbers and categories

-- Phone number cleaning had the biggest impact on unique customer counts

-- Category cleaning consolidated fragmented revenue

-- Assumptions:

-- One row = one transaction

-- Last 8 digits identify a customer

-- Risks:

-- Different customers may share the same phone digits

-- New formats or annotations may break the logic

-- Key point:
-- Without text standardization, KPIs are unreliable.