-- Xom Data · Products more expensive than the category average
-- Problem: https://xomdata.com/practice/medium-subquery-103
-- Solved: 2026-08-27

WITH product_stats AS (
    SELECT 
    product_name,
    category,
    price,
    AVG(price) OVER(PARTITION BY category) AS category_avg
FROM products)
SELECT 
    product_name,
    category,
    price,
    ROUND(price - category_avg,0) AS diff_from_avg,
    ROUND((price - category_avg)*100/category_avg,2) AS pct_above
FROM product_stats
WHERE price > category_avg
ORDER BY pct_above DESC,
         product_name ASC;
