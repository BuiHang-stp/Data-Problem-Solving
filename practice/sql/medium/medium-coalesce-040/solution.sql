-- Xom Data · Book count and average price by genre
-- Problem: https://xomdata.com/practice/medium-coalesce-040
-- Solved: 2026-08-27

WITH detail AS( 
    SELECT 
    genre_name,
    COUNT(b.id) AS book_count,
    COALESCE(AVG(b.price),0) AS avg_price,
    COALESCE(MIN(b.price),0) AS min_price,
    COALESCE(MAX(b.price),0) AS max_price
FROM genres g
LEFT JOIN books b 
ON g.id = b.genre_id
GROUP BY genre_name
)
SELECT
    genre_name,
    book_count,
    avg_price,
    min_price,
    max_price,
    max_price - min_price AS price_range,
    RANK() OVER(
        ORDER BY book_count DESC
    ) AS coverage_rank,
    NTILE(3) OVER(ORDER BY 
        book_count DESC,
        genre_name ASC
    ) AS library_focus
FROM detail
ORDER BY coverage_rank ASC,
         genre_name ASC;
