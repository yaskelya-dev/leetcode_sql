DO $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname = 'yes_no_enum') THEN
        CREATE TYPE yes_no_enum AS ENUM ('Y', 'N');
    END IF;
END $$;

CREATE TABLE IF NOT EXISTS Employee (
    employee_id INT,
    department_id INT,
    primary_flag yes_no_enum
);

TRUNCATE TABLE Employee;
INSERT INTO Employee (employee_id, department_id, primary_flag) VALUES
('1', '1', 'N'),
('2', '1', 'Y'),
('2', '2', 'N'),
('3', '3', 'N'),
('4', '2', 'N'),
('4', '3', 'Y'),
('4', '4', 'N');
