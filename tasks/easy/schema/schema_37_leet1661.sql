DO $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname = 'activity_enum') THEN
        CREATE TYPE activity_enum AS ENUM ('start', 'end');
    END IF;
END $$;

-- 2. Создаем таблицу с использованием нового типа ENUM
CREATE TABLE IF NOT EXISTS Activity (machine_id INT, process_id INT, activity_type activity_enum, timestamp FLOAT);

-- 3. Очищаем таблицу
TRUNCATE TABLE Activity;

-- 4. Вставляем все данные одним запросом (числа пишем без кавычек)
INSERT INTO Activity (machine_id, process_id, activity_type, timestamp) VALUES
(0, 0, 'start', 0.712),
(0, 0, 'end', 1.52),
(0, 1, 'start', 3.14),
(0, 1, 'end', 4.12),
(1, 0, 'start', 0.55),
(1, 0, 'end', 1.55),
(1, 1, 'start', 0.43),
(1, 1, 'end', 1.42),
(2, 0, 'start', 4.1),
(2, 0, 'end', 4.512),
(2, 1, 'start', 2.5),
(2, 1, 'end', 5);
