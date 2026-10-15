SELECT
    p.product_id,
    CASE
        WHEN SUM(us.units) IS NULL OR SUM(us.units) = 0 THEN 0
        ELSE ROUND(SUM(p.price * us.units) / SUM(us.units)::numeric, 2)
    END AS average_price
FROM prices AS p
LEFT JOIN unitssold AS us
ON p.product_id = us.product_id AND
    (us.purchase_date BETWEEN p.start_date AND p.end_date)
GROUP BY p.product_id