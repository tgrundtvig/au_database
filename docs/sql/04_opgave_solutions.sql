-- Solutions for Opgave 4
-- Database: northwind

USE northwind;

-- =============================================================================
-- 4.1: Count customers by country, sorted descending
-- =============================================================================

SELECT country_region AS Country,
       COUNT(*) AS 'Antal kunder'
FROM customers
GROUP BY country_region
ORDER BY COUNT(*) DESC;


-- =============================================================================
-- 4.2: Count shipments by shipper
-- =============================================================================

SELECT s.company AS CompanyName,
       COUNT(o.id) AS 'Antal forsendelser'
FROM shippers s
LEFT JOIN orders o ON s.id = o.shipper_id
GROUP BY s.id, s.company
ORDER BY s.company;


-- =============================================================================
-- 4.3: Count orders and total sales by employee (LastName only)
-- Sorted descending by number of orders
-- =============================================================================

SELECT e.last_name AS LastName,
       COUNT(DISTINCT o.id) AS 'Antal Ordre',
       ROUND(SUM(od.quantity * od.unit_price), 2) AS 'Total Salg'
FROM employees e
LEFT JOIN orders o ON e.id = o.employee_id
LEFT JOIN order_details od ON o.id = od.order_id
GROUP BY e.id, e.last_name
ORDER BY COUNT(DISTINCT o.id) DESC;


-- =============================================================================
-- 4.4: Categorize products by demand using CASE statement
-- Categories: Lille (<=10), Medium (11-25), Stor (>25)
-- =============================================================================

SELECT p.product_name AS ProductName,
       COUNT(od.product_id) AS Count_Product,
       CASE
           WHEN COUNT(od.product_id) <= 10 THEN 'Lille'
           WHEN COUNT(od.product_id) > 10 AND COUNT(od.product_id) <= 25 THEN 'Medium'
           WHEN COUNT(od.product_id) > 25 THEN 'Stor'
       END AS Efterspørgsel
FROM products p
LEFT JOIN order_details od ON p.id = od.product_id
GROUP BY p.id, p.product_name
ORDER BY COUNT(od.product_id);


-- =============================================================================
-- 4.5: Find customers with 3 or more orders
-- Expected: 7 Rows
-- =============================================================================

SELECT c.id AS ID,
       c.company AS CompanyName,
       COUNT(o.id) AS 'Antal Ordre'
FROM customers c
LEFT JOIN orders o ON c.id = o.customer_id
GROUP BY c.id, c.company
HAVING COUNT(o.id) >= 3
ORDER BY COUNT(o.id) DESC;

-- Verify count
SELECT COUNT(*) AS row_count
FROM (
    SELECT c.id
    FROM customers c
    LEFT JOIN orders o ON c.id = o.customer_id
    GROUP BY c.id
    HAVING COUNT(o.id) >= 3
) AS customer_counts;


-- =============================================================================
-- 4.6: Find products sold less than 150 units
-- Expected: 19 Rows
-- =============================================================================

SELECT p.id AS product_id,
       p.product_name AS product_name,
       SUM(od.quantity) AS 'Antal solgt'
FROM products p
LEFT JOIN order_details od ON p.id = od.product_id
GROUP BY p.id, p.product_name
HAVING SUM(od.quantity) < 150
ORDER BY SUM(od.quantity) ASC;

-- Verify count
SELECT COUNT(*) AS row_count
FROM (
    SELECT p.id
    FROM products p
    LEFT JOIN order_details od ON p.id = od.product_id
    GROUP BY p.id
    HAVING SUM(od.quantity) < 150
) AS product_counts;
