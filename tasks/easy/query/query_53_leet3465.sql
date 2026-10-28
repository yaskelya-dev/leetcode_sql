SELECT *
FROM products
WHERE description ~ '\ySN\d{4}-\d{4}\y'
ORDER BY product_id
