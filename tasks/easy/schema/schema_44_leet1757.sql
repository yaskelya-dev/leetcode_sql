DO $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname = 'yes_no_enum') THEN
        CREATE TYPE yes_no_enum AS ENUM ('Y', 'N');
    END IF;
END $$;

CREATE TABLE IF NOT EXISTS Products (
    product_id INT,
    low_fats yes_no_enum,
    recyclable yes_no_enum
);

TRUNCATE TABLE Products;
INSERT INTO Products (product_id, low_fats, recyclable) VALUES
('0', 'Y', 'N'),
('1', 'Y', 'Y'),
('2', 'N', 'Y'),
('3', 'Y', 'Y'),
('4', 'N', 'N');
