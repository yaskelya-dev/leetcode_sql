# Video 01

## 0. Подготовка окружения

Объясню в рамках интереактивного контейнера с Ubuntu:
```commandline
docker run -it ubuntu:latest bash
```

Устанавливаем и запускаем PostgreSQL:
```commandline
# Обновляем индексы и устанавливаем Postgres
apt update && apt install postgresql postgresql-contrib

# Запускаем службу PostgreSQL
service postgresql start
```

Переключаемся на системного пользователя postgres и входим в консоль psql:
```commandline
# Переходим под пользователя postgres
su - postgres

# Запускаем CLI клиент psql
psql
```

Создание пользователя и БД:
```SQL
-- Создаем пользователя с паролем
CREATE USER leetcode_user WITH PASSWORD 'leetcode_pass';

-- Создаем базу данных для тестов
CREATE DATABASE leetcode_db OWNER leetcode_user;

-- Даем пользователю все права на БД
GRANT ALL PRIVILEGES ON DATABASE leetcode_db TO leetcode_user;

-- Выходим из psql
\q
```

Подключаемся к БД под новым пользователем:
```commandline
psql -h 127.0.0.1 -U leetcode_user -d leetcode_db
```


## 1. Структура SQL-запроса
Пишется запрос в одном порядке, но исполняется в другом

| Порядок написания      | Порядок исполнения                           |
|:-----------------------|:---------------------------------------------|
| `SELECT`               | `FROM` + `JOIN` (выбор и объединение таблиц) |
| `FROM / JOIN ... ON`   | `WHERE` (фильтрация отдельных строк)         |
| `WHERE`                | `GROUP BY` (группировка)                     |
| `GROUP BY`             | `HAVING` (фильтрация агрегированных групп)   |
| `HAVING`               | `SELECT` (вычисление колонок, псевдонимы)    |
| `ORDER BY`             | `DISTINCT` (удаление дубликатов)             |
| `LIMIT / OFFSET`       | `ORDER BY` (сортировка)                      |
|                        | `LIMIT / OFFSET` (пагинация)                 |

Именно из-за такого порядка исполнения в блоке `WHERE` нельзя использовать псевдонимы из `SELECT` или агрегатные функции вроде `COUNT(*)`


## 2. Базовый каркас и фильтрация (WHERE)
Конструкции: `WHERE`, `AND`, `OR`, `IS NULL`, `IS NOT NULL`, `BETWEEN`, `LIKE`, `~` (регулярки), `INTERVAL`
1. Простая фильтрация - `WHERE id > 50 AND name IS NOT NULL`
2. Диапазоны дат - `date BETWEEN '2019-05-02' AND '2019-06-01'`
3. Работа с интервалами времени (PostgreSQL) - `date + INTERVAL '1 day'` - постоянно встречается в задачах на поиск событий "на следующий день"
4. Поиск по строкам:
   - `LIKE 'A%'` - простой поиск по шаблону (`%` - любое количество символов, `_` - один символ)
   - `~ '^[A-Z]'` - регулярные выражения для сложных паттернов (например, валидностьь email)


## 3. Объединение таблиц (JOIN)
Конструкции: `LEFT JOIN`, `RIGHT JOIN`, `FULL JOIN`, `CROSS JOIN`
1. `LEFT JOIN ... ON` - забирает всё из левой таблицы. Если в правой нет совпадений, то подставляется `NULL`. Используется очень часто
```SQL
SELECT *
FROM employees AS e
LEFT JOIN departments AS d 
ON e.dept_id = d.id;
```
2. `RIGHT JOIN` - то же самое, что и `LEFT JOIN`, только забирает всё из правой таблицы. Чаще всего используют именно `LEFT JOIN`, можно просто менять таблицы местами
```SQL
SELECT *
FROM employees AS e
RIGHT JOIN departments AS d 
ON e.dept_id = d.id;
```
3. `FULL JOIN` - сохраняет строки из обеих страниц, даже если нет совпадений
```SQL
SELECT *
FROM employees AS e
FULL JOIN departments AS d 
ON e.dept_id = d.id;
```
4. `CROSS JOIN` - перемножает каждую строку левой таблицы с каждой строкой правой
```SQL
SELECT 
    s.size,
    c.color
FROM sizes AS s
CROSS JOIN colors AS c;
```


## 4. Группировка и агрегация
Конструкции: `GROUP BY`, `HAVING`, `COUNT`, `SUM`, `AVG`, `MIN`, `MAX`, `COUNT(DISTINCT)`
1. `GROUP BY job` - схлопывает строки с одинаковым значением `job` в одну группу 
2. `HAVING COUNT(*) > 1` - фильтрует уже сгруппированные данные (в отличие от `WHERE`, который фильтрует строки до группировки) 
3. `COUNT(DISTINCT user_id)` - считает только уникальных пользователей в группе


## 5. Трансформация данных и условные конструкции
Конструкции: `CASE WHEN`, `условная агрегация (PIVOT)`, `ROUND()`, `::numeric`
1. `CASE WHEN` - аналог if/else в SQL:
```SQL
   UPDATE salary 
   SET sex = CASE 
      WHEN sport = 'basket' THEN 'volley' 
      WHEN sport = 'volley' THEN 'basket' 
   END;
```
2. Условная агрегация - расчёт агрегатных функций только для строк, которые подходят под определённые условия
```SQL
SELECT 
    id,
    SUM(CASE WHEN month = 'Jan' THEN revenue END) AS Jan_Revenue,
    SUM(CASE WHEN month = 'Feb' THEN revenue END) AS Feb_Revenue
FROM Department
GROUP BY id;

```
3. Округение - `ROUND(val, 2)`
4. Приведение типов - если делить целые числа, то результат будет целым числом: `5 / 2 = 2`


## 6. Работа со строками и сцепка
Конструкции: `UPPER`, `LOWER`, `SUBSTRING`, `STRING_AGG`
1. `UPPER(name)`, `LOWER(name)` - изменение регистра
2. `SUBSTRING(name FROM 1 FOR 1)` - извлечение части строки
3. `STRING_AGG(DISTINCT product, ',' ORDER BY product)` - собирает значения из нескольких строк одной группы в одну текстовую строку через запятую. Крайне полезно для задач формирования отчётов


## 7. Подзапросы и хитрые паттерны LeetCode
Конструкции: `IN`, `NOT IN`, скалярный подзапрос в `SELECT`, Unpivot через `CROSS JOIN LATERAL`
1. Подзапросы `IN`, `NOT IN` - позволяет делать фильтрацию по списку значений, полученных из другого запроса:
```SQL
DELETE FROM Person 
WHERE id NOT IN (
    SELECT MIN(id) FROM Person GROUP BY email
);
```
2. Скалярный подзапрос в `SELECT` - гарантирует возврат `NULL`. Если задача просит вернуть 2 значение, то `LIMIT 1 OFFSET 1` может вернуть 0 строк для пустой таблицы
```SQL
SELECT (
    SELECT DISTINCT salary 
    FROM Employee 
    ORDER BY salary DESC 
    LIMIT 1 OFFSET 1
) AS SecondHighestSalary;
```
3. Обратный разворот таблицы (Unpivot) через `CROSS JOIN LATERAL`. Берется 1-ая строка товара `p`. Блок `VALUES` подставляет значения из этой строки и делает из них табличку из 3 строк. `CROSS JOIN` прикрепляет эти 3 строки к товару. В итоге 1 строка таблицы трансформируется в 3 строки
```SQL
SELECT p.product_id, u.store, u.price
FROM Products AS p
CROSS JOIN LATERAL (
  VALUES 
    ('store1', p.store1),
    ('store2', p.store2),
    ('store3', p.store3)
) AS u(store, price)
WHERE u.price IS NOT NULL;
```


## 8. Сортировка и пагинация
Конструкции: `ORDER BY`, `LIMIT`, `OFFSET`
1. `ORDER BY salary DESC, name ASC` - сортируем строки по убыванию цены, а если цена одинаковая, то по алфавиту имён
2. `LIMIT 5 OFFSET 10` - пропустить первые 10 строк и взять следующие 5


## 9. Вставка, обновление и удаление данных
1. `INSERT INTO` вставка данных в таблицу
```SQL
INSERT INTO sizes (size)
VALUES ('XL'), ('XXL');
```
2. `DELETE` удаляет строки из таблицы, подходящие под условие `WHERE` 
### Если забыть про `WHERE`, то очистится вся таблица!
```SQL
DELETE FROM Employee
WHERE salary > 100000;
```
3`UPDATE` меняет значения в конкретных колонках для строк, подходящих под условие `WHERE`
```SQL
UPDATE players
SET caste = 'gambler', status = 'no risk no rich'
WHERE sport = 'poker';
```


## 10'. Создание БД и таблицы
#### Создание БД:
```SQL
CREATE DATABASE my_database;
```
#### Создание таблицы:
```SQL
CREATE TABLE table_name (
    column1 datatype constraints,
    column2 datatype constraints,
    ...
);
```


## 11'. Полезные материалы:
[Видеокурс Андрея Созыкина](https://www.youtube.com/watch?v=uGKIXTUjZbc&list=PLtPJ9lKvJ4oh5SdmGVusIVDPcELrJ2bsT&pp=mAkA)

