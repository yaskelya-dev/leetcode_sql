SELECT
    eu.unique_id,
    e.name
FROM employees AS e
LEFT JOIN employeeuni AS eu
ON e.id = eu.id
