# Opgave 4

Du skal bruge database **Northwind** til alle opgaverne.

**Brug ER-diagramet!**

---

## 4.1
Find antallet af customers i hvert land (country_region).
Overskriften på "antal" kolonnen skal være "Antal kunder".
Skal sorteres i faldende orden.

---

## 4.2
Find det antal forsendelser der er sendt med hver af de tre "Shippers" vi bruger.
Overskriften på antal kolonnen skal være "Antal forsendelser".

---

## 4.3
Find antallet af ordre og det totale salg for hver af de ansatte.
Det er kun last_name der skal med fra employees tabellen.
De to beregnings kolonner skal have overskriften "Antal Ordre" og "Total Salg".
Skal sorteres i faldende orden efter "Antal Ordre".

---

## 4.4
Vis hvilken kategori efterspørgslen for et produkt falder indenfor:

1. Hvis antal produkter solgt er mindre end eller lig med 10 = **Lille**
2. Hvis antal produkter solgt er større end 10, men mindre end eller lig med 25 = **Medium**
3. Hvis antal produkter solgt er større end 25 = **Stor**

Du skal tælle på order_details.product_id (antal gange produktet optræder i ordrer).
Du skal også vise product_name fra products tabellen og antallet af produkter.

---

## 4.5
Find alle Customers der har lagt 3 eller flere ordre.
Vis følgende felter, sorteret i faldende orden efter antal ordre:
- ID
- company (CompanyName)
- Antal Ordre

**Resultat: 7 Rows**

---

## 4.6
Find de produkter fra order_details hvor der er solgt mindre end 150 stk i alt.
Vis følgende felter i stigende orden efter antal solgt:
- product_id
- product_name
- Antal solgt

**Resultat: 19 Rows**

---
