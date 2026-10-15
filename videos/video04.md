### `::date` приводим строку к дате, чтобы отнимать потом интервал

### Объединяем значения из строк
```SQL
STRING_AGG(DISTINCT product, ',' ORDER BY product) AS products
```
