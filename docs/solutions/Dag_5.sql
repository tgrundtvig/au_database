/*
	Stored Procedure
*/

-- OrderByYear
USE northwind;

DELIMITER $$
CREATE PROCEDURE OrderByYear(Aar INT)
BEGIN
	SELECT * FROM Orders
	WHERE YEAR(OrderDate) = Aar;
END $$
DELIMITER ;

-- Afvikling af SP
CALL OrderByYear(1996);
    
    
-- OrderByYearMonth
USE Northwind;

DELIMITER $$
CREATE PROCEDURE OrderByYearMonth(Aar INT, Mdr INT)
BEGIN
	select 
		Products.ProductID,
		Products.ProductName
	from Products
	join Order_Details
	on Products.ProductID = Order_Details.ProductID
	join Orders 
	on Order_Details.OrderID = Orders.OrderID
	where year(Orders.OrderDate) = Aar and
		month(Orders.orderdate) = Mdr;
END $$
DELIMITER ;

CALL OrderByYearMonth (1997, 5);
CALL OrderByYearMonth (@Mdr = 5, @Aar = 1997);

-- Vis SP i databasen
SHOW PROCEDURE STATUS WHERE db = 'northwind';

-- Vis SQL koden for en SP
SHOW CREATE PROCEDURE OrderByYearMonth;


/*
TRIGGER
*/
USE Northwind;

-- Demo Audit Table
CREATE TABLE employees_audit (
    id INT AUTO_INCREMENT PRIMARY KEY,
    EmployeeID INT NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Changedat DATETIME DEFAULT NULL,
    action VARCHAR(50) DEFAULT NULL
);

-- BEFORE UPDATE Trigger
DELIMITER $$
CREATE TRIGGER before_employee_update 
    BEFORE UPDATE ON Employees
    FOR EACH ROW 
BEGIN
    INSERT INTO employees_audit
    SET action = 'update',
		EmployeeID = OLD.EmployeeID,
        LastName = OLD.LastName,
        changedat = NOW(); 
END $$
DELIMITER ;

-- Test af Trigger
UPDATE employees 
SET 
    LastName = 'Hellstern'
WHERE
    EmployeeID = 5;
    
SELECT * FROM employees;
SELECT * FROM employees_audit;

-- Vis TRIGGER
SHOW TRIGGERS;

-- Via TRIGGER Tabellen
SELECT * FROM
	information_schema.triggers
WHERE
    trigger_schema = 'northwind';

-- Bestem Tabel
SELECT * FROM
    information_schema.triggers
WHERE
    trigger_schema = 'northwind'
        AND event_object_table = 'Employees';


/* 
Export CSV
*/
USE northwind;


select * from mysql.user;

(SELECT
		'CustomerID',
        'CompanyName',
        'Address',
        'City',
        'Region',
        'PostalCode',
        'Country'
)
UNION
(SELECT 
		CustomerID,
        CompanyName,
        Address,
        City,
        Region,
        PostalCode,
        Country
FROM customers
WHERE Country = 'USA'
INTO OUTFILE 'E:\\Customer_USA.csv'
FIELDS ENCLOSED BY '"'
TERMINATED BY ';'
LINES TERMINATED BY '\n');


/*
Import CSV
*/

-- Opret Import Tabel
CREATE TABLE `Customers_USA` 
(
  `CustomerID` varchar(5) NOT NULL PRIMARY KEY,
  `CompanyName` varchar(40) NOT NULL,
  `Address` varchar(60) DEFAULT NULL,
  `City` varchar(15) DEFAULT NULL,
  `Region` varchar(15) DEFAULT NULL,
  `PostalCode` varchar(10) DEFAULT NULL,
  `Country` varchar(15) DEFAULT NULL
);

-- Import 
LOAD DATA INFILE 'E:\\Customer_USA.csv'
INTO TABLE Customers_USA
FIELDS ENCLOSED BY '"'
TERMINATED BY ';'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

SELECT * FROM Customers_USA;
