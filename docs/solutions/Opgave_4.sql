/*
	Opgave 4
    Løsning
    Tue Hellstern
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