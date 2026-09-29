SELECT (
    SELECT num
    FROM mynumbers
    GROUP BY num
    HAVING COUNT(*) <= 1
    ORDER BY num DESC
    LIMIT 1
)