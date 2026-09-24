Очистка схемы перед новым заданием:
```SQL
DROP SCHEMA public CASCADE;
CREATE SCHEMA public;
```

`CASE WHEN` - аналог if/else в SQL:
```SQL
SELECT
    *,
    CASE
        WHEN x + y <= z OR x + z <= y OR y + z <= x THEN 'No'
        ELSE 'Yes'
    END AS triangle
FROM triangle
```
