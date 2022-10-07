/*
	Opgave 4
    Løsning
    Tue Hellstern
*/




-- Biblioteksopgaven

create database if not exists library; 

use library;

create table if not exists library (
Id int auto_increment primary key,
LibraryName varchar(50),
Address varchar(50)
);


create table if not exists BooksInLibraries (
BookId int,
LibraryId int,
NumberOfBooks int
);

create table if not exists Book(
Id int auto_increment primary key,
Title varchar(50),
Author varchar(50)
);


insert into library(LibraryName, Address) values
("lib A", "A Road"),("lib B", "B Road"),("lib C", "C Road");


insert into BooksInLibraries(BookId, LibraryId, NumberOfBooks) values
(1,2,3),(1,3,1),(2,1,2),(2,2,1),(3,1,1),(3,2,2),(3,3,2);

insert into library(LibraryName, Address) values
("lib A", "A Road"),("lib B", "B Road"),("lib C", "C Road");


insert into Book(Title, Author) values
("Donald Duck", "Disney"),("Mickey Mouse", "Disney"),("Pluto", "John");


/*

Opgave 1: 
Opret Database og tabeller. Indsæt data i tabellerne som vist. 

Opgave 2:
Lav en SQL-forespørgsel for at vise de bøger, som en given forfatter har skrevet.

select Title, Author from Book;

Opgave 3:
Lav en SQL-forespørgsel for at vise, hvor en given bog kan findes.

select LibraryName, Address, Title, Author
from Library 
inner join BooksInLibraries 
on library.Id = BooksInLibraries.LibraryId
inner join Book 
on Book.Id = BooksInLibraries.BookId
Order by LibraryName

Opgave 4:
Lav en SQL-forespørgsel for at vise antallet af forskellige bøger på et givet bibliotek.

select LibraryName,
COUNT(BookId) AS 'Antal af forskellige bøger'
from Library 
inner join BooksInLibraries 
on library.Id = BooksInLibraries.LibraryId
Group by LibraryName;

Opgave 5:
Lav en SQL-forespørgsel for at vise antallet af bøger på et givet bibliotek.

select LibraryName,
sum(NumberOfBooks) AS 'Antal af bøger'
from Library 
inner join BooksInLibraries 
on library.Id = BooksInLibraries.LibraryId
Group by LibraryName;

*/

-- 4.1
SELECT
	Customers.Country,
	COUNT(Customers.CustomerID) AS 'Antal kunder'
FROM Customers
GROUP BY Country
ORDER BY COUNT(Customers.CustomerID) DESC;


-- 4.2
SELECT 
	Shippers.CompanyName, 
    COUNT(Orders.OrderID) AS 'Antal forsendelser' 
FROM Orders LEFT JOIN Shippers 
ON Orders.ShipVia = Shippers.ShipperID
GROUP BY Shippers.CompanyName;

-- 4.3
SELECT
	Employees.LastName,                            
    COUNT(Orders.OrderID) AS 'Antal Ordre',
	SUM((UnitPrice * Quantity) - (UnitPrice * Quantity * Discount)) AS 'Total Salg'
FROM Orders INNER JOIN Employees
ON Orders.EmployeeID = Employees.EmployeeID
INNER JOIN Order_Details
ON Orders.OrderID = Order_Details.OrderID
GROUP BY LastName
ORDER BY COUNT(Orders.OrderID) DESC;

-- 4.4
 SELECT 
	Products.ProductName,
    COUNT(Order_Details.ProductID) Count_Product,
    	CASE 			
		WHEN COUNT(Order_Details.ProductID) <= 10 THEN 'Lille'			
		WHEN COUNT(Order_Details.ProductID) <= 25 THEN 'Medium'			
		WHEN COUNT(Order_Details.ProductID) > 25 THEN 'Stor'				
	END AS Efterspørgsel
 FROM Products INNER JOIN Order_Details
 ON Products.ProductID = Order_Details.ProductID
 GROUP BY Products.ProductName
 ORDER BY Count_Product;
 
-- 4.5
SELECT 
	Orders.CustomerID,
    Customers.CompanyName,
    COUNT(OrderID) AS 'Antal Ordre'
FROM Orders INNER JOIN Customers
ON Orders.CustomerID = Customers.CustomerID
GROUP BY Orders.CustomerID
HAVING COUNT(OrderID) > 15
ORDER BY COUNT(OrderID) DESC;

-- 4.6
SELECT 
	Order_Details.ProductID, 
    Products.ProductName,
    SUM(Quantity) AS 'Antal solgt'
FROM Order_Details INNER JOIN Products
ON Order_Details.ProductID = Products.ProductID
GROUP BY ProductID
HAVING SUM(Quantity) < 200
ORDER BY SUM(Quantity);


-- INDEX 


CREATE INDEX FK_CustomerID ON Orders (CustomerID); 
-- Flere kolonner 

CREATE INDEX Emp_name ON Employees (LastName, FirstName); 

-- Unikt Index 

/*  Det kan fx bruges til at sikre at en 
kunde ikke oprettes to gange - 
kunne fx være kundens CVR-nummer.*/

CREATE UNIQUE INDEX UniqProduct ON Products (ProductName); 

-- Slet index 
ALTER TABLE Employees DROP INDEX Emp_name; 

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

-- Eksempel fra kursusgang 4 

SELECT Customers.CompanyName,
SUM(Order_Details.UnitPrice * Order_Details.Quantity) as Total,
 CASE
 WHEN SUM(Order_Details.UnitPrice * Order_Details.Quantity) > 15000 THEN 'Cust A'
 WHEN SUM(Order_Details.UnitPrice * Order_Details.Quantity) >= 10000 THEN 'Cust B'
 WHEN SUM(Order_Details.UnitPrice * Order_Details.Quantity) < 10000 THEN 'Cust C'
 END AS Customer_Group
 FROM Customers INNER JOIN Orders
 ON Customers.CustomerID = Orders.CustomerID
 INNER JOIN Order_Details 
 ON Orders.OrderID = Order_Details.OrderID 
 GROUP BY Customers.CompanyName
 ORDER BY Total DESC; 
 
 
 -- Eksempel fra kursusgang 4 som stored procedure 
 
 DELIMITER $$
 create procedure abc_kunder(a INT, b INT, c INT)
 BEGIN
 select
 SUM(Order_Details.UnitPrice * Order_Details.Quantity) as Total,
 CASE
 WHEN SUM(Order_Details.UnitPrice * Order_Details.Quantity) > a THEN 'Cust A'
 WHEN SUM(Order_Details.UnitPrice * Order_Details.Quantity) >= b THEN 'Cust B'
 WHEN SUM(Order_Details.UnitPrice * Order_Details.Quantity) < c THEN 'Cust C'
 END AS Customer_Group
 FROM Customers INNER JOIN Orders
 ON Customers.CustomerID = Orders.CustomerID
 INNER JOIN Order_Details 
 ON Orders.OrderID = Order_Details.OrderID 
 GROUP BY Customers.CompanyName
 ORDER BY Total DESC; 
 
 END $$ DELIMITER ; 
 
 call abc_kunder(15000, 8000, 8000);
 
 
 -- TRIGGER 
USE northwind; 
-- Demo Audit Table 

CREATE TABLE employees_audit(
id INT AUTO_INCREMENT PRIMARY KEY,
EmployeeID INT NOT NULL, 
LastName VARCHAR(50) NOT NULL,
Changedate DATETIME DEFAULT NULL, 
action VARCHAR(50) DEFAULT NULL 
); 

-- BEFORE UPDATE Trigger 

DELIMITER $$ CREATE TRIGGER before_employee_update 
BEFORE UPDATE ON Employees 
FOR EACH ROW BEGIN 
INSERT INTO employees_audit SET action = 'update', 
EmployeeID = OLD.EmployeeID, LastName = OLD.LastName, changedate = NOW(); 
END $$ DELIMITER ; 

-- Test af Trigger 
UPDATE employees SET 
LastName = 'Hellstern' WHERE 
EmployeeID = 5;


SELECT * FROM employees; SELECT * FROM employees_audit; 

-- Slet TRIGGER 
DROP TRIGGER before_employee_update; 

-- Vis TRIGGER 
SHOW TRIGGERS; 

-- Via TRIGGER Tabellen 
SELECT * FROM information_schema.triggers 
WHERE trigger_schema = 'northwind'; 

-- Bestem Tabel 
SELECT * FROM information_schema.triggers 
WHERE trigger_schema = 'northwind' 
AND event_object_table = 'Employees'; 
 
 




