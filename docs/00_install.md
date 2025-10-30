# Installation af MySQL

Denne guide viser hvordan du installerer MySQL server og MySQL Workbench på din computer.

## MySQL Server

Du skal installere MySQL Community Server version **8.4.6 LTS** (Long Term Support).

### Download og Installation

Brug de officielle MySQL installationsguides for din platform:

*   **Windows:** [https://dev.mysql.com/doc/refman/8.0/en/windows-installation.html](https://dev.mysql.com/doc/refman/8.0/en/windows-installation.html)
*   **macOS:** [https://dev.mysql.com/doc/refman/8.0/en/macos-installation.html](https://dev.mysql.com/doc/refman/8.0/en/macos-installation.html)
*   **Linux:** [https://dev.mysql.com/doc/refman/8.4/en/linux-installation.html](https://dev.mysql.com/doc/refman/8.4/en/linux-installation.html)

**VIGTIGT:** Under installationen vil du blive bedt om at sætte et root-password. **Husk dette password!**

## MySQL Workbench

MySQL Workbench er et grafisk værktøj til at arbejde med MySQL-databaser.

### Download

Download MySQL Workbench fra den officielle MySQL website:

[https://dev.mysql.com/downloads/workbench/](https://dev.mysql.com/downloads/workbench/)

Følg installationsinstruktionerne for din platform.

### Opret Forbindelse til MySQL Server

1.  Åbn MySQL Workbench
2.  Opret en ny forbindelse til din lokale MySQL-server:
    *   **Connection Name:** `localhost`
    *   **Hostname:** `127.0.0.1`
    *   **Port:** `3306`
    *   **Username:** `root`
    *   **Password:** Klik på "Store in Keychain/Vault" og indtast det root-password, du valgte under installationen af MySQL Server.
3.  Klik på "Test Connection" for at verificere forbindelsen
4.  Klik på "OK" for at gemme forbindelsen

## Sample Databases

For at få data at arbejde med, skal du importere Northwind og Employees databaserne.

### Import via Command Line

Du kan indlæse databaserne direkte via kommandolinjen:

```bash
# Northwind database
mysql -u root -p < docs/sql/samples/northwind.sql
mysql -u root -p < docs/sql/samples/northwind-data.sql

# Employees database (dette kan tage flere minutter)
mysql -u root -p < docs/sql/samples/employees.sql
```

### Import via MySQL Workbench

*   **Northwind:**
    1.  Find filerne `northwind.sql` og `northwind-data.sql` i mappen `docs/sql/samples`.
    2.  Åbn `northwind.sql` i MySQL Workbench og kør scriptet (klik på lynet-ikonet).
    3.  Åbn `northwind-data.sql` i MySQL Workbench og kør scriptet.
*   **Employees:**
    1.  Find filen `employees.sql` i mappen `docs/sql/samples`.
    2.  Åbn `employees.sql` i MySQL Workbench og kør scriptet. Dette vil oprette databasestrukturen og importere data (~4 millioner records).
    3.  **Bemærk:** Import af Employees databasen kan tage 5-10 minutter.

### Verificer Installation

For at verificere at databaserne er indlæst korrekt, kør følgende i MySQL Workbench eller kommandolinjen:

```sql
SHOW DATABASES;
USE northwind;
SHOW TABLES;
SELECT COUNT(*) FROM customers;

USE employees;
SHOW TABLES;
SELECT COUNT(*) FROM employees;
```

Du skulle se:
- **northwind** med 13 tabeller
- **employees** med 6 tabeller og cirka 300,000 employee records
