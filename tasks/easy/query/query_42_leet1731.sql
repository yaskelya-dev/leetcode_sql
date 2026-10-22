SELECT
    e1.reports_to AS employee_id,
    MIN(e2.name) AS name,
    COUNT(*) AS reports_count,
    ROUND(AVG(e1.age), 0) AS average_age
FROM employees AS e1
INNER JOIN employees AS e2
ON e1.reports_to = e2.employee_id
WHERE e1.reports_to IS NOT NULL
GROUP BY e1.reports_to
ORDER BY employee_id
