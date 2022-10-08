/*
	Eksempel på:
    - Mange til Mange relation
    - Løsning med "mellem" tabel
    - Tabel med 2 felter som en kombineret Primær nøgle

	Tue Hellstern
*/

-- Opret Database
CREATE DATABASE MineAnsatte;
USE MineAnsatte;

-- Opret Tabeller
  CREATE TABLE PostNrBy 
(
	Postnr VARCHAR(12) PRIMARY KEY,
    Byen VARCHAR(59)
);

/*
-- Indsæt data - DK Postnummer
-- Brug evt. enten GUI Import funktione eller LOAD DATA og hent fra en komplet CSV fil
*/

-- LOAD DATA via SQL kommando
LOAD DATA INFILE '/var/lib/mysql-files/postnumer.csv' 
INTO TABLE  PostNrBy
FIELDS TERMINATED BY ',' 
-- ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;


/*
INSERT INTO PostNrBy
VALUES
	(3000, 'Helsingør'),
	(4000, 'Roskilde'),
	(5000, 'Odense');
*/
-- SELECT * FROM PostNrBy;
-- DELETE FROM PostNrBy;


CREATE TABLE Ansatte 
(
	idAnsatte INT PRIMARY KEY,
	Navn VARCHAR(45),
	Adresse VARCHAR(45),
	Postnr VARCHAR(12),
	FOREIGN KEY (Postnr) REFERENCES PostNrBy(Postnr)
);

CREATE TABLE ArbejdsSteder 
(
	idArbejdssteder INT PRIMARY KEY AUTO_INCREMENT,
	Stednavn VARCHAR(45) NULL,
	Adresse VARCHAR(45) NULL,
	Postnr VARCHAR(12),
    FOREIGN KEY (Postnr) REFERENCES PostNrBy(Postnr)
);

CREATE TABLE AnsatteSteder
(
	idAnsatte INT NOT NULL,
	idArbejdssteder INT NOT NULL,
	StartDato DATE,
	SlutDato DATE,
	PRIMARY KEY (idAnsatte, idArbejdssteder, StartDato),
    FOREIGN KEY (idAnsatte) REFERENCES Ansatte(idAnsatte),
    FOREIGN KEY (idArbejdssteder) REFERENCES ArbejdsSteder(idArbejdssteder)
);

INSERT INTO Ansatte
VALUES
	(1, 'Ole', 'Kongevejen 5', 3000),
    (2, 'Lise', 'Strandvejen 2', 4000),
    (3, 'Peter', 'Hovedgaden 60', 3000),
    (4, 'Pia', 'Strandgade 8', 3000);
    
INSERT INTO ArbejdsSteder (Stednavn, Adresse, Postnr)
VALUES
	('Kontrobygning 1', 'Kontrovej 3', 4000),
    ('Nyt hus 1', 'Hovedgaden 3', 3000),
    ('Sommerhus 1', 'Sommervej 99', 5000),
    ('Etage ejendom', 'Langegade 4', 3000);
    
-- Test af hvem der er sat ind
select * from PostNrBy;
select * from Ansatte;
select * from ArbejdsSteder;


/* 
	Test af Postnr relationen
    Det er IKKE muligt hvorfor?
*/
INSERT INTO Ansatte
VALUES (5, 'Ole', 'Kongevejen 5', 6666);

-- Indsæt data i mellemtabellen
-- Husk dato på formatet - YYYY-MM-DD
INSERT INTO AnsatteSteder (idAnsatte, idArbejdssteder, StartDato, SlutDato)
VALUES
	(1, 3, '2018-05-14', '2018-06-16'),
    (2, 3, '2018-06-10', '2018-10-20'),
    (4, 4, '2018-05-15', NULL),
    (3, 1, '2018-01-02', NULL);
    
SELECT * FROM AnsatteSteder;

-- Test af Primary Key 
-- Kun dato er forskelig
INSERT INTO AnsatteSteder (idAnsatte, idArbejdssteder, StartDato, SlutDato)
VALUES (1, 3, '2018-10-21', NULL);

/*
	Test af reference
    Dette er IKKE muligt hvorfor?
*/
INSERT INTO AnsatteSteder (idAnsatte, idArbejdssteder, StartDato, SlutDato)
VALUES (7, 3, '2018-10-21', NULL);
    
    