/*
	Kursusgang 4
    Tue Hellstern
*/

/*
	Funktioner
*/
use northwind;

select 
	OrderID,
    OrderDate,
    day(OrderDate) as Dag,
    month(OrderDate) as Måned,
    year(OrderDate) as År
from Orders;

/*
	Beregninger
*/
select
	OrderID,
    ProductID,
    UnitPrice,
    Quantity,
    Discount,
    UnitPrice * Quantity as Pris_Uden_Rabat
from Order_Details;

/*
	Funktioner
*/

-- AVG
SELECT AVG(UnitPrice)
FROM Products;

-- MIN
SELECT MIN(UnitPrice)
FROM Products;

-- MAX
SELECT MAX(UnitPrice)
FROM Products;

-- COUNT 
SELECT COUNT(ProductID)
FROM Products;

-- SUM
SELECT
    SUM((UnitPrice * Quantity) - (UnitPrice * Quantity * Discount)) AS Sale
FROM Order_Details;

/* 
	GROUP BY
*/
SELECT
	Order_Details.OrderID,
	COUNT(Order_Details.Quantity) AS Antal,
    SUM((UnitPrice * Quantity) - (UnitPrice * Quantity * Discount)) AS Sale
FROM Order_Details
GROUP BY Order_Details.OrderID;

SELECT
	Employees.LastName,                            
    COUNT(Orders.OrderID) AS 'Antal Orders'
FROM Orders INNER JOIN Employees
ON Orders.EmployeeID = Employees.EmployeeID
GROUP BY LastName;

/*
	HAVING
*/
-- Denne virker IKKE
SELECT 
	Country,
	COUNT(CustomerID)
FROM Customers
GROUP BY Country
WHERE COUNT(CustomerID) > 5;

-- Denne VIRKER - der bruges HAVING og IKKE WHERE
SELECT 
	Country,
	COUNT(CustomerID)
FROM Customers
GROUP BY Country
HAVING COUNT(CustomerID) > 5;

-- WHERE brugt FØR GROUP BY
SELECT 
	Country,
	COUNT(CustomerID)
FROM Customers
WHERE Country IN ('UK', 'USA', 'Italy')
GROUP BY Country;

-- Kombination af WHERE og HAVING
SELECT 
	Country,
	COUNT(CustomerID)
FROM Customers
WHERE Country IN ('UK', 'USA', 'Italy')
GROUP BY Country
HAVING COUNT(CustomerID) > 5;


/*
	INDEX
*/
CREATE INDEX FK_CustomerID
ON Orders (CustomerID);

-- Flere kolonner
CREATE INDEX Emp_name
ON Employees (LastName, FirstName);

-- Unikt Index
CREATE UNIQUE INDEX UniqProduct
ON Products (ProductName);

-- Slet index
ALTER TABLE Employees
DROP INDEX Emp_name;

/*
	CASE
*/

-- CASE der viser efterspørgslen af et Produkt
-- fordelt på Lille, Medium og Stor
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
 
 -- Skal vises "On Time" hvis en ordre er blev afsendt til tiden 
 -- og "Late", hvis ordren blev afsendt for sent
 SELECT 
	Customers.CustomerID, 
    Customers.CompanyName, 
    Employees.EmployeeID, 
    Employees.FirstName, 
    Employees.LastName, 
    Orders.OrderID,
	CASE
		WHEN ShippedDate < RequiredDate
			THEN 'On Time'
			ELSE 'Late'
	END AS Shipped
FROM Orders INNER JOIN Employees 
ON Employees.EmployeeID = Orders.EmployeeID
INNER JOIN Customers 
ON Customers.CustomerID = Orders.CustomerID
ORDER BY Shipped;


-- Customeres opdelt i A, B og C kunder
SELECT 
	Customers.CompanyName,
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
