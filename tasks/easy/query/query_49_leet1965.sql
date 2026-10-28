SELECT
    CASE
        WHEN e.employee_id IS NULL THEN s.employee_id
        ELSE e.employee_id
    END AS employee_id
FROM employees AS e
FULL JOIN salaries AS s
ON e.employee_id = s.employee_id
WHERE e.name IS NULL OR s.salary IS NULL
ORDER BY employee_id
