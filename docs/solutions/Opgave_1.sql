/*
Opgave 1
    
    Det er databasen Employees der 
    skal bruges til hele opgaven
*/
use employees;
/*
1.1
	Du skal hente alle kolonner og alle data 
    fra tabellen employees

	Resultat: 300.024 rows
*/
select * from employees;

/*
1.2
	Du skal hente alle data 
    fra tabellen employees
    men kun first_name, last_name og gender

	Resultat: 300.024 rows
*/
select
	first_name,
	last_name,
    gender
from employees;

/*
1.3
	Du skal hente de forskellige
    titler fra tabellen titles
    Hver titel skal kun vises en gang
    
    Resultat: 7 Rows
*/
select distinct title
from titles;

/*
1.4
	Du skal hente alle ansatte fra 
    tabellen employees der er kvinder.
    Sorter i faldende orden efter first_name
    
    Resultat: 120.051 Rows
*/
select * from employees
where gender = 'F'
order by first_name DESC;

/*
1.5
	Du skal hente alle ansatte fra 
    tabellen employees der er kvinder
    
    Resultat: 120.051 Rows
*/
select * from employees
where gender = 'F';


/*
1.6
	Find alle ansatte fra tabellen employees
    der har fødselsdag i december måned
    
    Tip: brug MONTH(birth_date)
    
    Resultat: 25.326 Rows
*/
select * from employees
where MONTH(birth_date) = 12;

/*
1.7
	Find alle ansatte fra tabellen employees 
    der er ansat i enten november eller december
    
    Tip: brug MONTH(hire_date)
    
    Resultat: 48.371 Rows
*/
select * from employees
where month(hire_date) = 11
or month(hire_date) = 12;

/*
1.8
	Find alle ansatte fra tabellen employees der 
    er ansat i november måned 1991
    
    Tip: brug YEAR(hire_date)
    
    Resultat: 1.779 Rows 
*/
select * from employees
where year(hire_date) = 1991
and month(hire_date) = 11;

/*
1.9
	Find alle ansatte fra tabellen employees der 
    IKKE er ansat i november måned 1991
    Sorter efter hire_date i stigende orden
    
    Resultat: 255.373 Rows 
*/
select * from employees
where not year(hire_date) = 1991
and not month(hire_date) = 11
order by hire_date;

/*
1.10
	Find alle ansatte fra tabellen employees
    der har et emp_no mellem 20000 og 20500
    
    Resultat: 501 Rows 
*/
select * from employees
where emp_no between 20000 and 20500;

/*
1.11
	Find alle ansatte fra tabellen employees 
    der er ansat i følgende måneder:
    
    Januar - 1
    Marts - 3
    Maj - 5
    November - 11
    
    Sorter efter hire_date i stigende orden
    
    Resultat: 100.581 Rows 
*/
select * from employees
where month(hire_date) in (1, 3, 5, 11)
order by hire_date;
