/*
	Dag 2
	Tue Hellstern
*/

-- Database
CREATE DATABASE Kunder;
-- DROP DATABASE Kunder;
USE Kunder;

-- Tabel
CREATE TABLE Kunder
	(
		Kunde_Id INT PRIMARY KEY,
		Kunde_Navn VARCHAR(60)
	);
    
CREATE TABLE Kunder
	(
		Kunde_Id INT,
		Kunde_Navn VARCHAR(60),
		PRIMARY KEY (Kunde_Id)
	);
    
-- DROP TABLE Kunder;

-- Alter
ALTER TABLE Kunder
ADD Kunde_Adresse VARCHAR(50);

ALTER TABLE Kunder
DROP COLUMN Kunde_Adresse;

ALTER TABLE Kunder
MODIFY COLUMN Kunde_Adresse VARCHAR(80);

-- PK
ALTER TABLE Kunder
ADD PRIMARY KEY (Kunde_Id);

ALTER TABLE Kunder
ADD CONSTRAINT PK_KundeId PRIMARY KEY (Kunde_Id, Kunde_Navn);

-- PK DROP
ALTER TABLE Kunder
DROP PRIMARY KEY;


-- NULL
select * 
from Customers
where FAX is null;


-- DEFAULT
CREATE TABLE Kunder
	(
		Kunde_Id INT PRIMARY KEY,
		Kunde_Navn VARCHAR(60),
        Kunde_OpretDate DATETIME DEFAULT NOW()
	);
    
INSERT INTO Kunder (Kunde_id, Kunde_Navn)
VALUES (
	2,
    'Hansen'
);

select * from Kunder;

ALTER TABLE Kunder
ALTER COLUMN Kunde_OpretDate DROP DEFAULT;	

-- UPDATE
DROP TABLE Kunder;

CREATE TABLE Kunder
	(
		Kunde_Id INT,
		Kunde_Navn VARCHAR(60),
		PRIMARY KEY (Kunde_Id)
	);
    
INSERT INTO Kunder
VALUES(
	1,
    'Hansen'
),
(
	2,
    'Olsen'
);

SELECT * FROM Kunder;

UPDATE Kunder
SET Kunde_Navn = 'Hellstern'
WHERE Kunde_Id = 2;
    
-- AUTO INCEREMENT
DROP TABLE Kunder;

	CREATE TABLE	Kunder
	(
		Kunde_Id INT PRIMARY KEY AUTO_INCREMENT,
		Kunde_Navn VARCHAR(60) NOT NULL,
		Kunde_Adresse VARCHAR (50) 
	);

INSERT INTO Kunder (Kunde_Navn, Kunde_Adresse)
VALUES (
	'Olsen',
    'Kongevejen 2'
);

SELECT * FROM Kunder;

ALTER TABLE Kunder AUTO_INCREMENT=100;
