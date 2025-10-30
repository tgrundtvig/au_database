-- Solutions for Opgave 2
--
-- NOTE: Exercises 2.10-2.13 reference columns from the original Microsoft Northwind
-- database that don't exist in our version. Solutions are adapted where possible.

-- =============================================================================
-- PART 1: DDL Operations (2.1 - 2.7)
-- =============================================================================

-- 2.1: Create a new database named venner
DROP DATABASE IF EXISTS venner;
CREATE DATABASE venner;

-- 2.2: Create table with specified fields
USE venner;

CREATE TABLE venner (
    ID INT PRIMARY KEY AUTO_INCREMENT,
    Fornavn VARCHAR(50),
    Efternavn VARCHAR(50),
    Adresse VARCHAR(100),
    Postnr INT DEFAULT 3000,
    Mobil VARCHAR(20),
    Email VARCHAR(100)
);

-- 2.3: Insert the specified records
INSERT INTO venner (Fornavn, Efternavn, Adresse, Postnr, Mobil, Email) VALUES
('Ole', 'Hansen', 'Strandvejen 3', DEFAULT, '+45 12345678', 'ole@test.dk'),
('Lis', 'Olsen', 'Kongevejen 21', 4000, '+45 87654321', 'lis@test.dk'),
('Peter', 'Hansen', 'Strandgade 7', DEFAULT, '+45 56784321', 'peter@test.dk'),
('Ulla', 'Rasmussen', 'Hovedgaden 5', 4000, '+45 43215678', 'ulla@test.dk');

-- Verify insertion
SELECT * FROM venner;

-- 2.4: Add column Fodselsdag to table venner
ALTER TABLE venner ADD COLUMN Fodselsdag DATE;

-- 2.5: Insert birthday values
UPDATE venner SET Fodselsdag = '1978-02-10' WHERE Fornavn = 'Ole' AND Efternavn = 'Hansen';
UPDATE venner SET Fodselsdag = '2001-02-05' WHERE Fornavn = 'Lis' AND Efternavn = 'Olsen';
UPDATE venner SET Fodselsdag = '2010-05-14' WHERE Fornavn = 'Peter' AND Efternavn = 'Hansen';
UPDATE venner SET Fodselsdag = '1955-09-08' WHERE Fornavn = 'Ulla' AND Efternavn = 'Rasmussen';

-- Verify updates
SELECT * FROM venner;

-- 2.6: Delete all with last name Hansen
DELETE FROM venner WHERE Efternavn = 'Hansen';

-- Verify deletion (should only have 2 rows: Lis and Ulla)
SELECT * FROM venner;

-- 2.7: Update address for Lis Olsen
UPDATE venner
SET Adresse = 'Gurrevej 2', Postnr = 3000
WHERE Fornavn = 'Lis' AND Efternavn = 'Olsen';

-- Verify update
SELECT * FROM venner;


-- =============================================================================
-- PART 2: Query Exercises (2.8 - 2.13)
-- =============================================================================

-- 2.8: Find emp_no from salaries hired after 2001-12-31 with salary > 150000
-- Expected: 10 Rows
USE employees;

SELECT DISTINCT emp_no
FROM salaries
WHERE from_date > '2001-12-31'
  AND salary > 150000;

-- Verify count
SELECT COUNT(DISTINCT emp_no) AS row_count
FROM salaries
WHERE from_date > '2001-12-31'
  AND salary > 150000;


-- 2.9: Find all with 25 year anniversary - hired in 1994, sorted by gender (F first)
-- Expected: 14,835 Rows
USE employees;

SELECT *
FROM employees
WHERE YEAR(hire_date) = 1994
ORDER BY gender ASC, hire_date;

-- Verify count
SELECT COUNT(*) AS row_count
FROM employees
WHERE YEAR(hire_date) = 1994;


-- 2.10: Find customers where web_page is empty (NULL or empty string)
-- Expected: 29 Rows
USE northwind;

SELECT *
FROM customers
WHERE web_page IS NULL OR web_page = '';

-- Verify count
SELECT COUNT(*) AS row_count
FROM customers
WHERE web_page IS NULL OR web_page = '';


-- 2.11: Find products where discontinued = 1
-- Expected: 2 Rows
USE northwind;

SELECT *
FROM products
WHERE discontinued = 1;

-- Verify count
SELECT COUNT(*) AS row_count
FROM products
WHERE discontinued = 1;


-- 2.12: Find products where price (list_price) is between 10 and 15
-- Expected: 6 Rows
USE northwind;

SELECT *
FROM products
WHERE list_price BETWEEN 10 AND 15
ORDER BY list_price DESC;

-- Verify count
SELECT COUNT(*) AS row_count
FROM products
WHERE list_price BETWEEN 10 AND 15;


-- 2.13: Find products from category 'Beverages' or 'Condiments'
-- Expected: 7 Rows
USE northwind;

SELECT *
FROM products
WHERE category IN ('Beverages', 'Condiments')
ORDER BY category;

-- Verify count
SELECT COUNT(*) AS row_count
FROM products
WHERE category IN ('Beverages', 'Condiments');
