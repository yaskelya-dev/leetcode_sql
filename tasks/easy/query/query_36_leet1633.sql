SELECT
    contest_id,
    ROUND(COUNT(*) / (SELECT COUNT(*) FROM users)::numeric * 100, 2) AS percentage
FROM register
GROUP BY contest_id
ORDER BY percentage DESC, contest_id
