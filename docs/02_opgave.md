# Opgave 2

## Del 1: DDL Operations (Data Definition Language)

### 2.1

Opret en ny database med navnet: `venner`

### 2.2

I databasen `venner` skal du oprette en tabel med følgende felter:

- ID
- Fornavn
- Efternavn
- Adresse
- Postnr
- Mobil
- Email

Feltet ID skal være Primary Key og være oprettet med AUTO INCREMENT
Feltet Postnr skal have en default værdi på 3000

### 2.3

Indsæt følgende poster i tabellen venner:

| Fornavn | Efternavn | Adresse       | Postnr  | Mobil        | Email         |
| ------- | --------- | ------------- | ------- | ------------ | ------------- |
| Ole     | Hansen    | Strandvejen 3 | default | +45 12345678 | ole@test.dk   |
| Lis     | Olsen     | Kongevejen 21 | 4000    | +45 87654321 | lis@test.dk   |
| Peter   | Hansen    | Strandgade 7  | default | +45 56784321 | peter@test.dk |
| Ulla    | Rasmussen | Hovedgaden 5  | 4000    | +45 43215678 | ulla@test.dk  |

### 2.4

Tilføj kolonnen Fodselsdag (DATE) til tabellen venner

### 2.5

Indsæt følgende værdier i feltet Fødselsdag:

| Fornavn | Efternavn | Fodselsdag |
| ------- | --------- | ---------- |
| Ole     | Hansen    | 10-02-1978 |
| Lis     | Olsen     | 05-02-2001 |
| Peter   | Hansen    | 14-05-2010 |
| Ulla    | Rasmussen | 08-09-1955 |

### 2.6

Slet alle personer der hedder Hansen til efternavn

### 2.7

Opdater adressen for Lis Olsen til Gurrevej 2, 3000

---

## Del 2: Query Exercises

### 2.8

Brug databasen **Employees**.

Find alle emp_no fra tabellen salaries der har from_date efter 31-12-2001 og har en salary der er større end 150.000

**Resultat: 10 Rows**

### 2.9

Brug databasen **Employees**.

Find alle der har 25 års jubilæum – det vil sige at de er blevet ansat (hire_date) i 1994.
Findes ud fra tabellen employees.
Skal sorteres efter gender – F først

(Det er kun hire_date du skal gå ud fra, om de er stoppet eller ej betyder ikke noget)

**Resultat: 14.835 Rows**

### 2.10

Brug databasen **Northwind**.

Fra tabellen customers skal du finde dem hvor web_page er tom (NULL eller tom streng)

**Resultat: 29 Rows**

### 2.11

Brug databasen **Northwind**.

Ud fra tabellen products skal du finde de produkter hvor discontinued = 1 (true).

**Resultat: 2 Rows**

### 2.12

Brug databasen **Northwind**.

Ud fra tabellen products skal du finde de produkter hvor prisen (list_price) er mellem 10 og 15.
Skal sorteres faldende efter list_price.

**Resultat: 6 Rows**

### 2.13

Brug databasen **Northwind**.

Ud fra tabellen products skal du finde de produkter der kommer fra kategori (category) 'Beverages' eller 'Condiments'.
Skal sorteres efter category.

**Resultat: 7 Rows**
