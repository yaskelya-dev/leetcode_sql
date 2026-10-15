SELECT
    query_name,
    ROUND(AVG(rating / position::numeric), 2) AS quality,
    ROUND((COUNT(*) FILTER(WHERE rating < 3)::numeric / COUNT(*)) * 100, 2) AS poor_query_percentage
FROM Queries
GROUP BY query_name
