SELECT
    MIN(u.name) AS name,
    SUM(t.amount) AS balance
FROM transactions AS t
LEFT JOIN users AS u
ON t.account = u.account
GROUP BY t.account
HAVING SUM(t.amount) > 10000
