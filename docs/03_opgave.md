# Opgave 3

Du skal bruge database **Employees** til alle opgaverne.

**Brug ER-diagramet!**

---

## 3.1
Fra tabellen **employees** skal du vælge first_name og last_name.
Fra tabellen **titles** skal du vælge title.
De to tabeller skal Joines med en INNER JOIN.
Du skal ikke tage højde for datoer.
Resultatet skal sorteres efter title.

**Resultat: 443.308 Rows**

---

## 3.2
Den SQL kode du har oprettet i 3.1 skal du gemme i et VIEW så det er nemt for brugeren at få disse data.
- Lav en test hvor du skriver: `SELECT * FROM employees_titel;`
- Navn på view: **employees_titel**

---

## 3.3
Find alle poster for emp_no **10003** i tabellen **salaries**.
Vis først_name og last_name fra **employees** tabellen.

**Resultat: 7 Rows**

---

## 3.4
Find alle employees der arbejder i afdelingen (dept_name) **Marketing**.
Du skal ikke tage højde for datoer.
Du skal vise: emp_no, first_name, last_name

**Resultat: 20.211 Rows**

---

## 3.5
Find alle employees der er ansat i afdelingen **Sales** eller **Marketing** for nuværende (to_date = '9999-01-01').
Vis: emp_no, first_name, dept_name
Skal sorteres efter last_name.

**Resultat: 52.543 Rows**

---

## 3.6
Find alle kvindelige employees (gender = 'F') der har titlen **Engineer**.
Du skal ikke tage højde for datoer.
Følgende felter skal vises: emp_no, first_name, last_name

**Resultat: 46.063 Rows**

---

## 3.7
Opret et VIEW der viser alle employees der er ansat i **1990**.
- Navn på view: **employees_1990**

**Resultat: 25.610 Rows**

---

## 3.8
Find det department der ikke har nogle ansatte tilknyttet.

**Resultat: 0 Rows** (Alle departmenter i denne database har tilknyttede ansatte)

---
