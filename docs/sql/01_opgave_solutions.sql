-- Solutions for Opgave 1
-- Database: employees
--
-- NOTE: The markdown file (01_opgave.md) has correct expected values.
-- The PDF (Opgave_1.pdf) has incorrect values for exercises 1.6 and 1.8:
--   1.6: PDF says 49,826 but correct answer is 48,371
--   1.8: PDF says 255,373 but correct answer is 298,245

USE employees;

-- 1.1: Get all columns and all data from employees table
-- Expected: 300,024 Rows
SELECT * FROM employees;

-- 1.2: Get first_name, last_name, gender from employees
-- Expected: 300,024 Rows
SELECT first_name, last_name, gender FROM employees;

-- 1.3: Get distinct titles from titles table
-- Expected: 7 Rows
SELECT DISTINCT title FROM titles;

-- 1.4: Get all female employees, sorted by first_name descending
-- Expected: 120,051 Rows
SELECT * FROM employees
WHERE gender = 'F'
ORDER BY first_name DESC;

-- 1.5: Find all employees with birthday in December
-- Expected: 25,326 Rows
SELECT * FROM employees
WHERE MONTH(birth_date) = 12;

-- 1.6: Find all employees hired in November or December
-- Expected: 48,371 Rows
SELECT * FROM employees
WHERE MONTH(hire_date) IN (11, 12);

-- 1.7: Find all employees hired in November 1991
-- Expected: 1,779 Rows
SELECT * FROM employees
WHERE YEAR(hire_date) = 1991 AND MONTH(hire_date) = 11;

-- 1.8: Find all employees NOT hired in November 1991, sorted by hire_date ascending
-- Expected: 298,245 Rows
SELECT * FROM employees
WHERE NOT (YEAR(hire_date) = 1991 AND MONTH(hire_date) = 11)
ORDER BY hire_date ASC;

-- 1.9: Find employees with emp_no between 20000 and 20500
-- Expected: 501 Rows
SELECT * FROM employees
WHERE emp_no BETWEEN 20000 AND 20500;

-- 1.10: Find employees hired in January, March, May, November, sorted by hire_date
-- Expected: 100,581 Rows
SELECT * FROM employees
WHERE MONTH(hire_date) IN (1, 3, 5, 11)
ORDER BY hire_date ASC;
