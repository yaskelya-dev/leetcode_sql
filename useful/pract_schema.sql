-- Очистка старых таблиц
DROP TABLE IF EXISTS employees CASCADE;
DROP TABLE IF EXISTS departments CASCADE;
DROP TABLE IF EXISTS sizes CASCADE;
DROP TABLE IF EXISTS colors CASCADE;
DROP TABLE IF EXISTS department_revenue CASCADE;
DROP TABLE IF EXISTS products CASCADE;
DROP TABLE IF EXISTS person CASCADE;
DROP TABLE IF EXISTS players CASCADE;

-- 1. Таблица отделов (для JOIN)
CREATE TABLE departments (
    id INT PRIMARY KEY,
    dept_name VARCHAR(50) NOT NULL
);

-- 2. Таблица сотрудников (для WHERE, GROUP BY, JOIN, ORDER BY)
CREATE TABLE employees (
    id INT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    dept_id INT,
    job VARCHAR(50),
    salary NUMERIC(10, 2),
    email VARCHAR(100),
    hire_date DATE
);

-- 3. Таблицы для CROSS JOIN
CREATE TABLE sizes (size VARCHAR(10));
CREATE TABLE colors (color VARCHAR(20));

-- 4. Таблица для условной агрегации (Pivot)
CREATE TABLE department_revenue (
    id INT,
    month VARCHAR(10),
    revenue INT
);

-- 5. Таблица для STRING_AGG и CROSS JOIN LATERAL (Unpivot)
CREATE TABLE products (
    product_id INT,
    product_name VARCHAR(50),
    store1 INT,
    store2 INT,
    store3 INT
);

-- 6. Таблица для DELETE и NOT IN
CREATE TABLE person (
    id INT PRIMARY KEY,
    email VARCHAR(100)
);

-- 7. Таблица для UPDATE и CASE WHEN
CREATE TABLE players (
    id INT PRIMARY KEY,
    name VARCHAR(50),
    sport VARCHAR(50),
    caste VARCHAR(50),
    status VARCHAR(50),
    sex CHAR(1)
);

-- ==========================================
-- ЗАПОЛНЕНИЕ ДАННЫМИ
-- ==========================================

INSERT INTO departments (id, dept_name) VALUES
(10, 'IT'),
(20, 'Sales'),
(30, 'HR');

INSERT INTO employees (id, name, dept_id, job, salary, email, hire_date) VALUES
(1, 'Simon', 10, 'Developer', 60000, 'simon@test.com', '2019-05-01'),
(2, 'Alice', 10, 'Developer', 75000, 'alice@test.com', '2019-05-15'),
(3, 'Bob', 20, 'Manager', 80000, 'bob@domain.org', '2019-05-20'),
(4, 'Clara', NULL, 'Manager', 45000, 'clara@test.com', '2019-06-02'),
(5, 'Daniel', 20, 'Developer', 55000, 'daniel@domain.org', '2019-06-10');

INSERT INTO sizes VALUES ('S'), ('M');
INSERT INTO colors VALUES ('Red'), ('Blue');

INSERT INTO department_revenue VALUES
(1, 'Jan', 8000),
(1, 'Feb', 7000),
(2, 'Jan', 9000),
(2, 'Feb', 6000);

INSERT INTO products VALUES
(1, 'Laptop', 100, 110, NULL),
(2, 'Phone', 200, NULL, 190);

INSERT INTO person VALUES
(1, 'john@example.com'),
(2, 'bob@example.com'),
(3, 'john@example.com');

INSERT INTO players VALUES
(1, 'Alex', 'poker', 'rookie', 'active', 'm'),
(2, 'Maria', 'basket', 'pro', 'active', 'f'),
(3, 'Elena', 'volley', 'pro', 'active', 'f');
