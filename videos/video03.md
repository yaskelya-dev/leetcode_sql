### Решение при отсутствии `PIVOT`:
```SQL
SELECT
    id,
    SUM(CASE WHEN month = 'Jan' THEN revenue END) AS Jan_Revenue,
    SUM(CASE WHEN month = 'Feb' THEN revenue END) AS Feb_Revenue,
    SUM(CASE WHEN month = 'Mar' THEN revenue END) AS Mar_Revenue,
```

### Помним про `::numeric`, когда делим целые числа

### Фильтрация `FILTER` внутри `SELECT`
```SQL
SELECT
    COUNT(*) FILTER (WHERE date < '2019-03-03') 
```
