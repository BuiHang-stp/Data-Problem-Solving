-- Xom Data · High-priced products
-- Problem: https://xomdata.com/practice/easy-where-002
-- Solved: 2026-08-24

SELECT 
    name,
    price
FROM products
WHERE price > 500000
ORDER BY price DESC;
