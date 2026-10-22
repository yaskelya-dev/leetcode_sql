SELECT
    p.product_id,
    u.store,
    u.price
FROM Products AS p
CROSS JOIN LATERAL (
    VALUES
    ('store1', p.store1),
    ('store2', p.store2),
    ('store3', p.store3)
) AS u(store, price)
WHERE u.price IS NOT NULL
