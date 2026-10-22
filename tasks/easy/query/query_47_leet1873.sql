SELECT
    employee_id,
    CASE
        WHEN employee_id % 2 = 1 AND LOWER(SUBSTRING(name, 1, 1)) != 'm' THEN salary
        ELSE 0
    END AS bonus
FROM employees
ORDER BY employee_id
