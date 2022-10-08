/*
	Skole / Klasse
    Normaliserings eksempel
    Tue Hellstern
*/
-- Opret Database
create database Skole;
use Skole;

-- Opret tabeller
create table Elev
(
	Elev_Id INT primary key auto_increment,
    Fornavn varchar(20),
    Efternavn varchar (40),
	Klasse varchar(3)
);

create table Klasselaere
(
	Klasselaere_Id int primary key auto_increment,
    Fornavn varchar(20),
    Efternavn varchar (40)
);

create table Fag
(
	Fag_Id Int primary key auto_increment,
    Fag varchar(30)
);

create table Klasse_Laere
(
	Klasse varchar(3),
    Klasselaere_Id int,
	PRIMARY KEY (Klasse, Klasselaere_Id)
);

Create table Karakter
(
	Elev_Id INT,
    Fag_Id int,
    Karakter varchar (2),
    PRIMARY KEY (Elev_Id, Fag_Id)
);

/*
	Indsæt data
*/

-- Elev
insert into Elev (Fornavn, Efternavn, Klasse)
values ('Ole', 'Hansen', '7 B'), ('Pia', 'Jensen', '7 B'), ('Kim', 'Larsen', '8 A'), ('Lise', 'Madsen', '8 A');

-- Klasselærer
insert into Klasselaere (Fornavn, Efternavn)
values ('Peter', 'Olsen'), ('Bodil', 'Klausen');

-- Fag
insert into Fag (Fag)
values ('Matematik Mundtlig'), ('Matematik Skriftlig'), ('Dansk'), ('Engelsk'), ('Tysk');

-- Klasse / Klasselærer
insert into Klasse_Laere 
values ('7 B', 1), ('8 A', 1),('8 A', 2);

-- Karakter
insert into Karakter
values
(101, 1, 7),
(101, 2, 10),
(101, 3, 4),
(101, 5, 7),
(102, 1, 10),
(102, 2, 10),
(102, 3, 7),
(102, 4, 10),
(201, 1, 7),
(201, 2, 7),
(201, 3, 2),
(201, 4, 7),
(201, 5, 10),
(202, 1, 4),
(202, 2, 10),
(202, 3, 10),
(202, 5, 4);

-- Test
select * from Elev;
select * from Klasselaere;
select * from Fag;
select * from Klasse_Laere;
select * from Karakter;

-- VIEWS
select * from Elev
join Klasselaere
on Elev