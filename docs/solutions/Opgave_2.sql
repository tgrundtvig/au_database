/*
	Opgave 2
    Tue Hellstern
*/

-- 2.1
create database venner;
use venner;
-- 2.2
create table venner
(
	ID INT primary key auto_increment,
    Fornavn varchar(20),
    Efternavn varchar(40),
    Adresse varchar(50),
    Postnr varchar(20) DEFAULT 3000,
    Mobil varchar(20),
    Email varchar(50)
);

-- 2.3
insert into venner (Fornavn, Efternavn, Adresse, Postnr, Mobil, Email)
values
('Ole', 'Hansen', 'Strandvejen 3', 3000, '+45 12345678', 'ole@test.dk'),
('Lis', 'Olsen', 'Kongevejen 21', 4000, '+45 87654321', 'lis@test.dk'),
('Peter', 'Hansen', 'Strandgade 7', 3000, '+45 56784321', 'peter@test.dk'),
('Ulla', 'Rasmussen', 'Hovedgaden 5', 4000, '+45 43215678', 'ulla@test.dk');

select * from venner;

-- 2.4
alter table venner
add Fodselsdag date;

-- 2.5
update venner
set Fodselsdag = '1978-02-10'
where ID = 1;

update venner
set Fodselsdag = '2001-02-05'
where ID = 2;

update venner
set Fodselsdag = '2010-05-14'
where ID = 3;

update venner
set Fodselsdag = '1955-09-08'
where ID = 4;

-- 2.6
SET SQL_SAFE_UPDATES = 0;

delete from venner
where Efternavn = 'Hansen';

SET SQL_SAFE_UPDATES = 1;


-- 2.7
SET SQL_SAFE_UPDATES = 0;

update venner
set Adresse = 'Gurrevejen 3' and Postnr = 3000
where Fornavn = 'Lis' and Efternavn = 'Olsen';

SET SQL_SAFE_UPDATES = 1;

/*
	SELECT del
*/
-- 2.8
use employees;

select * from salaries
where from_date > '2002-01-01' and
salary > 150000
order by salary;


-- 2.9
use employees;

select * from employees
where year(hire_date) = 1994
order by gender desc;


-- 2.10
use northwind;

select * from Suppliers
where Region is null and
HomePage is null;


-- 2.11
use northwind;

select * from Products
where UnitsInStock = 0 and
Discontinued = 0;


-- 2.12
use northwind;

select * from Products
where UnitPrice between 10 and 15
order by UnitPrice desc;


-- 2.13
use northwind;

select * from Products
where CategoryID in (1, 3, 8)
order by CategoryID;