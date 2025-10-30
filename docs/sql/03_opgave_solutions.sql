-- Solutions for Opgave 3
-- Database: employees

USE employees;

-- =============================================================================
-- 3.1: Join employees and titles tables
-- Expected: 443,308 Rows
-- =============================================================================

SELECT e.first_name, e.last_name, t.title
FROM employees e
INNER JOIN titles t ON e.emp_no = t.emp_no
ORDER BY t.title;

-- Verify count
SELECT COUNT(*) AS row_count
FROM employees e
INNER JOIN titles t ON e.emp_no = t.emp_no;


-- =============================================================================
-- 3.2: Create view from 3.1
-- View name: employees_titel
-- =============================================================================

DROP VIEW IF EXISTS employees_titel;

CREATE VIEW employees_titel AS
SELECT e.first_name, e.last_name, t.title
FROM employees e
INNER JOIN titles t ON e.emp_no = t.emp_no
ORDER BY t.title;

-- Test the view
SELECT * FROM employees_titel LIMIT 10;


-- =============================================================================
-- 3.3: Find all salaries for emp_no 10003 with employee name
-- Expected: 7 Rows
-- =============================================================================

SELECT e.first_name, e.last_name, s.salary
FROM salaries s
INNER JOIN employees e ON s.emp_no = e.emp_no
WHERE s.emp_no = 10003;

-- Verify count
SELECT COUNT(*) AS row_count
FROM salaries s
INNER JOIN employees e ON s.emp_no = e.emp_no
WHERE s.emp_no = 10003;


-- =============================================================================
-- 3.4: Find all employees in Marketing department
-- Expected: 20,211 Rows
-- =============================================================================

SELECT e.emp_no, e.first_name, e.last_name
FROM employees e
INNER JOIN dept_emp de ON e.emp_no = de.emp_no
INNER JOIN departments d ON de.dept_no = d.dept_no
WHERE d.dept_name = 'Marketing';

-- Verify count
SELECT COUNT(*) AS row_count
FROM employees e
INNER JOIN dept_emp de ON e.emp_no = de.emp_no
INNER JOIN departments d ON de.dept_no = d.dept_no
WHERE d.dept_name = 'Marketing';


-- =============================================================================
-- 3.5: Find current employees in Sales or Marketing departments
-- Current = to_date = '9999-01-01'
-- Expected: 52,543 Rows
-- =============================================================================

SELECT e.emp_no, e.first_name, d.dept_name
FROM employees e
INNER JOIN dept_emp de ON e.emp_no = de.emp_no
INNER JOIN departments d ON de.dept_no = d.dept_no
WHERE d.dept_name IN ('Sales', 'Marketing')
  AND de.to_date = '9999-01-01'
ORDER BY e.last_name;

-- Verify count
SELECT COUNT(*) AS row_count
FROM employees e
INNER JOIN dept_emp de ON e.emp_no = de.emp_no
INNER JOIN departments d ON de.dept_no = d.dept_no
WHERE d.dept_name IN ('Sales', 'Marketing')
  AND de.to_date = '9999-01-01';


-- =============================================================================
-- 3.6: Find female employees with title Engineer
-- Expected: 46,063 Rows
-- =============================================================================

SELECT DISTINCT e.emp_no, e.first_name, e.last_name
FROM employees e
INNER JOIN titles t ON e.emp_no = t.emp_no
WHERE e.gender = 'F'
  AND t.title = 'Engineer';

-- Verify count
SELECT COUNT(DISTINCT e.emp_no) AS row_count
FROM employees e
INNER JOIN titles t ON e.emp_no = t.emp_no
WHERE e.gender = 'F'
  AND t.title = 'Engineer';


-- =============================================================================
-- 3.7: Create view of employees hired in 1990
-- View name: employees_1990
-- Expected: 25,610 Rows
-- =============================================================================

DROP VIEW IF EXISTS employees_1990;

CREATE VIEW employees_1990 AS
SELECT *
FROM employees
WHERE YEAR(hire_date) = 1990;

-- Test the view
SELECT * FROM employees_1990 LIMIT 10;

-- Verify count
SELECT COUNT(*) AS row_count FROM employees_1990;


-- =============================================================================
-- 3.8: Find department with no employees
-- Expected: 0 Rows (all departments have employees in this database)
-- =============================================================================

SELECT d.dept_no, d.dept_name
FROM departments d
LEFT JOIN dept_emp de ON d.dept_no = de.dept_no
WHERE de.dept_no IS NULL;

-- Verify count
SELECT COUNT(*) AS row_count
FROM departments d
LEFT JOIN dept_emp de ON d.dept_no = de.dept_no
WHERE de.dept_no IS NULL;

-- Show all departments and their employee counts for reference
SELECT d.dept_no, d.dept_name, COUNT(de.emp_no) AS employee_count
FROM departments d
LEFT JOIN dept_emp de ON d.dept_no = de.dept_no
GROUP BY d.dept_no, d.dept_name
ORDER BY employee_count;
