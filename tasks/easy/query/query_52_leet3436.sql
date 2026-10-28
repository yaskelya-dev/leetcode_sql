SELECT *
FROM users
WHERE email ~ '^[A-Za-z0-9_]+@+[A-Za-z]+\.com$'
ORDER BY user_id
