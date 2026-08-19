-- Xom Data · High-rated sellers with many orders
-- Problem: https://xomdata.com/practice/medium-having-019
-- Solved: 2026-08-19

SELECT
    s.store_name,
    s.reputation_score,
    COUNT(o.id) AS order_count,
    DENSE_RANK() OVER (
        ORDER BY COUNT(o.id) DESC
    ) AS rank_by_orders,
    SUM(COUNT(o.id)) OVER (
        ORDER BY COUNT(o.id) DESC
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS cumulative_orders
FROM sellers s
JOIN orders o
    ON s.id = o.seller_id
WHERE s.reputation_score >= 4.5
GROUP BY
    s.id,
    s.store_name,
    s.reputation_score
HAVING COUNT(o.id) >= 3
ORDER BY
    rank_by_orders ASC,
    store_name ASC;
