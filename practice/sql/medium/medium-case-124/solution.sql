-- Xom Data · Classify student academic performance
-- Problem: https://xomdata.com/practice/medium-case-124
-- Solved: 2026-08-19

SELECT 
    st.full_name,
    st.student_code,
    ROUND(AVG(sc.final_score),2) AS avg_score,
    CASE
        WHEN ROUND(AVG(sc.final_score),2) >= 9 THEN 'Excellent'
        WHEN ROUND(AVG(sc.final_score),2) >= 8 THEN 'Good'
        WHEN ROUND(AVG(sc.final_score),2) >= 7 THEN 'Fair'
        WHEN ROUND(AVG(sc.final_score),2) >= 5 THEN 'Average'
        ELSE 'Poor'
    END AS grade,
    RANK() OVER(
        ORDER BY AVG(sc.final_score) DESC
    ) AS class_rank
FROM students st
LEFT JOIN scores sc
ON st.id = sc.student_id
GROUP BY 
    st.id, 
    st.full_name, 
    st.student_code
ORDER BY avg_score DESC,
         student_code ASC
LIMIT(20);
