/*
	Dag 1
	Tue Hellstern
*/

-- Vælg Database
use northwind;

-- SELECT
select * from Employees;

select 
	EmployeeID,
    FirstName,
    LastName
from Employees;

-- DISTINCT
select distinct Country from Customers;

-- WHERE
select * from Customers
where Country = 'Denmark';

select * from Orders
where year(OrderDate) = 1997;

-- AND
select * from Customers
where Country = 'USA'
and ContactTitle = 'Owner';

-- OR
select * from Customers
where Country = 'Denmark'
or Country = 'Sweden';

-- NOT
select * from Customers
where not Country = 'USA';

-- BETWEEN
select * from Orders
where EmployeeID between 3 and 5
order by EmployeeID;

-- IN
select * from Orders
where EmployeeID in (3, 5, 7)
order by EmployeeID;

select * from Orders
where month(OrderDate) in (2, 4, 6)
order by OrderDate;

-- ORDER BY
select * from Order_Details
order by UnitPrice ASC;

select * from Order_Details
order by UnitPrice DESC;