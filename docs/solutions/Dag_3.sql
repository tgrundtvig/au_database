/*
	Demo
    En til En relation
    Tue Hellstern
*/

create database test;
use test;

create table Ansatte
(
	ID int primary key auto_increment,
    Navn varchar(20)
);

create table Oplysninger
(
	ID int primary key,
    cpr varchar(11),
    Lon double,
    Pension double
);

/*
	JOINS
    Tue Hellstern
*/

-- INNER JOIN
create database Demo_Join;
use Demo_Join;

create table Kunder
(
	KundeId int primary key auto_increment,
    KundeNavn varchar(60)
);

create table Products
(
	ProductId int primary key auto_increment,
    ProductName varchar(60)
);

create table Ordre
(
	OrdreId int primary key auto_increment,
    KundeId int,
    ProductId int,
    Antal double,
    Pris double
);

-- Data
insert into Kunder (KundeNavn) values ('Bil Importen'), ('Cykel Importen'), ('Vin Importen'), ('Pc Importen');
insert into Products (ProductName) values ('Ford'), ('Rødvin'), ('Hvidvin'), ('IBM'), ('Hammer'), ('Toyota');
insert into Ordre (KundeId, ProductId, Antal, Pris) values
	(1, 1, 2, 120000), 
    (1, 6, 10, 250000),
    (3, 2, 4, 120),
    (3, 3, 7, 90),
    (4, 4, 10, 12000);

-- Test Select
select * from Kunder;
select * from Products;
select * from Ordre;

-- JOINS

-- INNER - 5 Rows
select
	Kunder.KundeId,
    Kunder.KundeNavn,
    Ordre.OrdreId,
    Ordre.ProductId,
    Ordre.Antal,
    Ordre.Pris
from Kunder
inner join Ordre
on Kunder.KundeId = Ordre.KundeId;

-- LEFT JOIN - 6 Rows
select
	Kunder.KundeId,
    Kunder.KundeNavn,
    Ordre.OrdreId,
    Ordre.ProductId,
    Ordre.Antal,
    Ordre.Pris
from Kunder
left join Ordre
on Kunder.KundeId = Ordre.KundeId;

-- RIGHT - 6 Rows
select
	Kunder.KundeId,
    Kunder.KundeNavn,
    Ordre.OrdreId,
    Ordre.ProductId,
    Products.ProductName,
    Ordre.Antal,
    Ordre.Pris
from Kunder
inner join Ordre
on Kunder.KundeId = Ordre.KundeId
right join Products
on Ordre.ProductId = Products.ProductId;

-- SELF JOIN
use northwind;

select
	Employees.EmployeeID,
	Employees.LastName,
    Employees.ReportsTo,
    Boss.EmployeeID,
    Boss.LastName
from Employees
join Employees Boss    
on Employees.reportsTo = Boss.EmployeeID
order by Employees.EmployeeID;


/*
	VIEWS
*/
use northwind;

create view Salg_Pr_Kunde AS

select 
	Customers.CustomerID,
    Customers.CompanyName,
    sum(Order_Details.UnitPrice * Order_Details.Quantity) as Salg
from Customers
join Orders
on Customers.CustomerID = Orders.CustomerID
join Order_Details
on Orders.OrderID = Order_Details.OrderID
group by Customers.CustomerID, Customers.CompanyName;



