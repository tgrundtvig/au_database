/*
	Opgave 3
    Tue Hellstern
*/

use employees;

-- 3.1
select
	employees.first_name,
    employees.last_name,
    titles.title
from employees
inner join titles
on employees.emp_no = titles.emp_no
order by titles.title;


-- 3.2
create view employees_titel
as
select
	employees.first_name,
    employees.last_name,
    titles.title
from employees
inner join titles
on employees.emp_no = titles.emp_no
order by titles.title;

select * from employees_titel;


-- 3.3
select
	employees.first_name,
    employees.last_name,
	salaries.salary
from employees
inner join salaries
on employees.emp_no = salaries.emp_no
where salaries.emp_no = 10003;


-- 3.4
select 
	employees.emp_no,
    employees.first_name,
    employees.last_name
from employees
inner join dept_emp
on employees.emp_no = dept_emp.emp_no
inner join departments
on dept_emp.dept_no = departments.dept_no
where departments.dept_name = 'Marketing';


-- 3.5
select 
	employees.emp_no,
    employees.first_name,
    employees.last_name,
    departments.dept_name
from employees
inner join dept_emp
on employees.emp_no = dept_emp.emp_no
inner join departments
on dept_emp.dept_no = departments.dept_no
where departments.dept_name in ('Marketing', 'Sales') and
dept_emp.to_date = '9999-01-01'
order by employees.last_name;

-- 3.6
select 
	employees.emp_no,
    employees.first_name,
	employees.last_name
from employees
inner join titles
on employees.emp_no = titles.emp_no
where titles.title = 'Engineer' and
employees.gender = 'F';

-- 3.7
create view employees_1990
as
select * from employees
where year(hire_date) = 1990;


-- 3.8
select 
	departments.dept_no,
	departments.dept_name
from departments
left join dept_emp
on departments.dept_no = dept_emp.dept_no
order by departments.dept_name desc;


-- 3.9
select 
	departments.dept_no,
	departments.dept_name	
from departments
left join dept_emp
on departments.dept_no = dept_emp.dept_no
where dept_emp.dept_no is null;


-- Tue
insert into departments
values ('d010', 'Transport');
