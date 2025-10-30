-- Solutions for Opgave 5
-- Database: northwind

USE northwind;

-- =============================================================================
-- DEL 1: STORED PROCEDURES
-- =============================================================================

-- 1. Find a customer by phone number
DELIMITER $$
DROP PROCEDURE IF EXISTS FindCustomerByPhone$$
CREATE PROCEDURE FindCustomerByPhone(IN phone_number VARCHAR(25))
BEGIN
    SELECT * FROM customers
    WHERE business_phone = phone_number
       OR home_phone = phone_number
       OR mobile_phone = phone_number;
END$$
DELIMITER ;

-- Test procedure 1
CALL FindCustomerByPhone('(123)555-0100');


-- 2. Find all employees hired after a specific date
DELIMITER $$
DROP PROCEDURE IF EXISTS FindEmployeesHiredAfter$$
CREATE PROCEDURE FindEmployeesHiredAfter(IN hire_date_param DATE)
BEGIN
    -- Note: Northwind employees table doesn't have hire_date,
    -- so this is adapted to work with the actual schema
    SELECT * FROM employees
    WHERE id > 0;  -- All employees (schema limitation)

    SELECT 'Note: Northwind employees table does not have hire_date column' AS notice;
END$$
DELIMITER ;

-- Test procedure 2
CALL FindEmployeesHiredAfter('2020-01-01');


-- 3. Find all orders by employee, sorted by zip code
-- Note: Northwind doesn't have gender field, so this finds orders by employee
DELIMITER $$
DROP PROCEDURE IF EXISTS FindOrdersByEmployee$$
CREATE PROCEDURE FindOrdersByEmployee()
BEGIN
    SELECT o.*, e.first_name, e.last_name
    FROM orders o
    INNER JOIN employees e ON o.employee_id = e.id
    ORDER BY o.ship_zip_postal_code;
END$$
DELIMITER ;

-- Test procedure 3
CALL FindOrdersByEmployee();


-- 4. Find all orders by a specific employee before a specific date
DELIMITER $$
DROP PROCEDURE IF EXISTS FindOrdersByEmployeeBeforeDate$$
CREATE PROCEDURE FindOrdersByEmployeeBeforeDate(
    IN employee_id_param INT,
    IN date_param DATE
)
BEGIN
    SELECT o.*, e.first_name, e.last_name
    FROM orders o
    INNER JOIN employees e ON o.employee_id = e.id
    WHERE o.employee_id = employee_id_param
      AND o.order_date < date_param
    ORDER BY o.order_date;
END$$
DELIMITER ;

-- Test procedure 4
CALL FindOrdersByEmployeeBeforeDate(1, '2006-02-01');


-- 5. Find all products from a category that were ordered after a specific date
DELIMITER $$
DROP PROCEDURE IF EXISTS FindProductsByCategoryAfterDate$$
CREATE PROCEDURE FindProductsByCategoryAfterDate(
    IN category_param VARCHAR(50),
    IN date_param DATE
)
BEGIN
    SELECT DISTINCT p.*, o.order_date
    FROM products p
    INNER JOIN order_details od ON p.id = od.product_id
    INNER JOIN orders o ON od.order_id = o.id
    WHERE p.category = category_param
      AND o.order_date > date_param
    ORDER BY o.order_date;
END$$
DELIMITER ;

-- Test procedure 5
-- First check what categories exist
SELECT DISTINCT category FROM products WHERE category IS NOT NULL;
-- Then call with an actual category
-- CALL FindProductsByCategoryAfterDate('Beverages', '2006-01-01');


-- =============================================================================
-- DEL 2: TRIGGERS
-- =============================================================================

-- First, create the Deleted_Products table to store deleted product data
DROP TABLE IF EXISTS Deleted_Products;
CREATE TABLE Deleted_Products (
    deleted_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    supplier_ids longtext,
    id int,
    product_code varchar(25),
    product_name varchar(50),
    description longtext,
    standard_cost decimal(19,4),
    list_price decimal(19,4),
    reorder_level int,
    target_level int,
    quantity_per_unit varchar(50),
    discontinued tinyint(1),
    minimum_reorder_quantity int,
    category varchar(50),
    attachments longblob
);

-- Trigger to copy product data before deletion
DELIMITER $$
DROP TRIGGER IF EXISTS before_product_delete$$
CREATE TRIGGER before_product_delete
BEFORE DELETE ON products
FOR EACH ROW
BEGIN
    INSERT INTO Deleted_Products (
        supplier_ids, id, product_code, product_name, description,
        standard_cost, list_price, reorder_level, target_level,
        quantity_per_unit, discontinued, minimum_reorder_quantity,
        category, attachments
    ) VALUES (
        OLD.supplier_ids, OLD.id, OLD.product_code, OLD.product_name, OLD.description,
        OLD.standard_cost, OLD.list_price, OLD.reorder_level, OLD.target_level,
        OLD.quantity_per_unit, OLD.discontinued, OLD.minimum_reorder_quantity,
        OLD.category, OLD.attachments
    );
END$$
DELIMITER ;

-- Test the trigger
-- First, insert a test product
INSERT INTO products (product_name, list_price, category)
VALUES ('Test Product for Deletion', 10.00, 'Test Category');

-- Get the ID of the test product
SET @test_product_id = LAST_INSERT_ID();

-- Delete the test product (trigger should fire)
DELETE FROM products WHERE id = @test_product_id;

-- Verify the trigger worked
SELECT * FROM Deleted_Products WHERE id = @test_product_id;


-- =============================================================================
-- DEL 3 & 4: TRANSACTIONS
-- =============================================================================

-- Example 1: Transfer product from one category to another (atomic operation)
START TRANSACTION;

UPDATE products
SET category = 'New Category'
WHERE id = 1;

-- If something goes wrong, we can rollback
-- ROLLBACK;

-- If everything is OK, commit the changes
COMMIT;


-- Example 2: Creating an order with order details (all or nothing)
START TRANSACTION;

-- Insert a new order
INSERT INTO orders (employee_id, customer_id, order_date, status_id)
VALUES (1, 1, NOW(), 0);

SET @new_order_id = LAST_INSERT_ID();

-- Add order details
INSERT INTO order_details (order_id, product_id, quantity, unit_price, status_id)
VALUES
    (@new_order_id, 1, 5, 10.00, 2),
    (@new_order_id, 2, 3, 15.00, 2);

-- Verify before committing
SELECT * FROM orders WHERE id = @new_order_id;
SELECT * FROM order_details WHERE order_id = @new_order_id;

-- Commit if everything looks good
COMMIT;

-- Clean up test order
DELETE FROM order_details WHERE order_id = @new_order_id;
DELETE FROM orders WHERE id = @new_order_id;


-- Example 3: Safe update with rollback on error
START TRANSACTION;

-- Update multiple related tables
UPDATE products SET list_price = list_price * 1.10 WHERE category = 'Beverages';

-- Check if the update affected the right number of rows
SELECT ROW_COUNT() AS rows_affected;

-- If we're not happy with the result, rollback
-- ROLLBACK;

-- Otherwise commit
COMMIT;


-- Example 4: Demonstrating ROLLBACK
START TRANSACTION;

-- Make some changes
DELETE FROM products WHERE id = 999;  -- This won't exist, so safe to test
INSERT INTO products (product_name, list_price) VALUES ('Temp Product', 5.00);

-- Check what we've done
SELECT * FROM products WHERE product_name = 'Temp Product';

-- Decide we don't want these changes
ROLLBACK;

-- Verify the rollback worked
SELECT * FROM products WHERE product_name = 'Temp Product';  -- Should return empty
