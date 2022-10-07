[Retur](README.md)

[Slide](slide_4.html)

# Kursusgang 4

### SQL fil
[Link til SQL fil](https://www.dropbox.com/s/86f940rvfq62giu/Dag_4.sql?dl=0)

## Funktioner

MySQL har mange funktioner som du kan bruge, nogle eksempler er:

- DAY()
- MONTH()
- YEAR()

**Eksempel fra Northwind**

```
SELECT 
    OrderID,
    OrderDate,
    DAY(OrderDate) as Dag,
    MONTH(OrderDate) as Måned,
    YEAR(OrderDate) as År
FROM Orders;
```

Du kan finde en oversigt her [Link](https://dev.mysql.com/doc/refman/8.0/en/func-op-summary-ref.html)

## Beregninger

Du har også mulighed for at foretage beregninger på dine data, det kan være simple beregninger som det at gange to kolonner med hinanden, eller det kan være beregninger hvor du bruger funktioner.

**SQL Beregninger**

- Plus: +
- Minus: -
- Gange: *
- Division: /
- Modulus: %

**Eksempel fra Northwind**

```
SELECT
    OrderID,
    ProductID,
    UnitPrice,
    Quantity,
    Discount,
    UnitPrice * Quantity as Pris_Uden_Rabat
FROM Order_Details;
```

### Brug af Funktioner

Du kan bruge forskellige beregningsfunktioner på dine data.

```
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
```


## GROUP BY
GROUP BY-sætningen bruges ofte sammen med en beregningsfunktioner som fx AVG, MIN, MAX, COUNT og SUM til at gruppere dit resultat.

Det kan f.eks. være det totale salg på en kunde eller et produkt.

```
SELECT
    Order_Details.OrderID,
    COUNT(Order_Details.Quantity) AS Antal,
    SUM((UnitPrice * Quantity) - (UnitPrice * Quantity * Discount)) AS Sale
FROM Order_Details
GROUP BY Order_Details.OrderID;

SELECT
    Employees.LastName,                            
    COUNT(Orders.OrderID) AS NumberOfOrders
FROM Orders INNER JOIN Employees
ON Orders.EmployeeID = Employees.EmployeeID
GROUP BY LastName:
```

## HAVING
Hvis du vil "udvælge" data på basis af en gruppering (GROUP BY) kan du IKKE bruge WHERE.

**Dette eksempel fra Northwind vil *ikke* virke**

```
SELECT 
	Country,
	COUNT(CustomerID)
FROM Customers
GROUP BY Country
WHERE COUNT(CustomerID) > 5;
```

Når der er foretaget en gruppering på *"CustomerID"* skal du bruge SQL kommandoen **HAVING** for at det virker.

**Samme eksempel fra Northwind, men med HAVING**

```
SELECT 
	Country,
	COUNT(CustomerID)
FROM Customers
GROUP BY Country
HAVING COUNT(CustomerID) > 5;
```

Det er muligt at bruge **WHERE** sammen med **GROUP BY** det skal bare være så du udvælger på data der ikke er grupperet på.

**Eksampel fra Northwind**

```
SELECT 
	Country,
	COUNT(CustomerID)
FROM Customers
WHERE Country IN ('UK', 'USA', 'Italy')
GROUP BY Country
HAVING COUNT(CustomerID) > 5;
```

## INDEX
Du kender et index fra en bog, hvor der typisk er et index bagerst i bogen. Det gør det nemmere og hurtigere at finde et bestemt ord/emne.

Det samme gælder når vi arbejder med index i SQL - index gør det hurtigere at finde data.

Som standard oprettes der et index når du opretter en primærnøgle. Dette index er et unikt index - *det er jo en primær nøgle.*

Du opretter et index med SQL kommandoen **CREATE INDEX**

```
CREATE INDEX index_navn
ON tabel_navn (felt_navn);

CREATE INDEX FK_CustomerID
ON Orders (CustomerID);

```

Brugeren kan ikke se de indexer der er oprettet, men du kan se dem under den enkelte tabel i mappen **Indexes**

![](images/Index_1.png)

Det er også muligt at oprette et index hvor du kombinerer flere kolonner.

**Eksempel fra Northwind**

```
CREATE INDEX Emp_name
ON Employees (LastName, FirstName);
```


### UNIQUE INDEX

Det er muligt at oprette et unikt index, ligesom det index der oprettes ved primærnøglen. Det kan fx bruges til at sikre at en kunde ikke oprettes to gange - kunne fx være kundens CVR-nummer.

```
CREATE UNIQUE INDEX index_navn
ON tabel_navn (felt_navn);

CREATE UNIQUE INDEX UniqProduct
ON Products (ProductName);
```


### DROP INDEX

Du kan fjerne et index med kommandoen **DROP INDEX** kombineret med **ALTER TABLE**

```
ALTER TABLE tabel_navn
DROP INDEX index_navn;

ALTER TABLE Employees
DROP INDEX Emp_name;
```

### Hvilke felter

*Hvilke felter skal du så oprette indekser på?*

Som udgangspunkt bliver der oprettet et unikt index på dine primærnøgle. Udover det vil det typisk være en fordel at oprette indekser på de felter der er **fremmede nøgler**.

Dernæst kan du med fordel oprette indekser på de felter hvor der søges meget. Det kan være svært at vide hvilke felter det er, en mulighed er at spørge brugerne eller bruge et analyse værktøj til at finde disse felter.

Der er dog en ulempe ved oprettelsen af indekser - Det at gemme data bliver **langsommere**. årsagen er, at indekserne skal opdateres med de nye data.

Hvis man skal indsætte eller opdatere store mængder data kan det være en fordel at slette dine indekser først og så oprette dem igen, når indsættelsen af data er færdig.


## CASE


En CASE-sætning opsætter forskellige betingelser som data "holdes" op imod. 

En CASE-sætning virker som en IF-THEN-ELSE sætning.

Når en værdi er SAND, falder indenfor en CASE, så returneres resultatet.

Hvis ingen betingelser er sande, returnerer den værdien i ELSE-klausulen.

```
CASE
    WHEN betingelse_1 THEN resultat_1
    WHEN betingelse_2 THEN resultat_2
    WHEN betingelse_n THEN resultat_n
    ELSE resultat
END;
```

**Eksempel fra Northwind**

```
SELECT 
	OrderID, 
	Quantity,
CASE
	WHEN Quantity > 30 THEN 'Antal er større end 30'
	WHEN Quantity = 30 THEN 'Antal er 30'
	ELSE 'Antal er under 30'
END AS 'Antal ordre'
FROM Order_Details;
```

Biblioteksopgave - [Link](https://docs.google.com/document/d/1DzlYTivp-5S8hoOtynDtkQIzDpKc2A55QAZ4VXTv208/edit?usp=sharing "https://docs.google.com/document/d/1DzlYTivp-5S8hoOtynDtkQIzDpKc2A55QAZ4VXTv208/edit?usp=sharing")


## Næste gang d. 11. maj

Løsning til Opgave 4

Færdigt ER-diagram

Overvejelser i forhold til Indexer


## Opgave 4, slides, løsning og noter 
Du kan hente opgave 4 her som PDF - [Opgave 4](Opgave_4.pdf)

noter for dag 4 - [noter dag 4]( https://drive.google.com/open?id=13OWzswBtLqkmZuzMPSzG2PEmsVexREx1  "https://drive.google.com/open?id=13OWzswBtLqkmZuzMPSzG2PEmsVexREx1")

Løsning til opgave 4 - [Løsning opgave 4](sql_filer/Opgave_4.sql)

[Retur](README.md)
