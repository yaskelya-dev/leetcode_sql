SELECT
    MIN(p.product_name) AS product_name,
    SUM(o.unit) AS unit
FROM orders AS o
LEFT JOIN products AS p
ON o.product_id = p.product_id
WHERE o.order_date BETWEEN '2020-02-01' AND '2020-03-01'::date - INTERVAL '1 day'
GROUP BY o.product_id
HAVING SUM(o.unit) >= 100
