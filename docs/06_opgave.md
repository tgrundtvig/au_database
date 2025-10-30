# Opgave 6: Sikkerhed og Backup

Denne opgavesæt fokuserer på praktisk arbejde med brugerstyring og sikkerhed i MySQL, samt backup og restore af databaser.

## Øvelse 6.1 - Opret en read-only bruger til Northwind

Opret en MySQL bruger kaldet `reader_nw` der kan læse fra Northwind databasen, men ikke kan ændre data.

**Trin:**
1. Opret brugen med passord `secure_read_nw`
2. Grant kun SELECT privilege på northwind databasen
3. Verifikation: Kør `SHOW GRANTS FOR 'reader_nw'@'localhost';`

**Forventet resultat:** Bruger kan køre SELECT queries men ikke INSERT, UPDATE, DELETE

---

## Øvelse 6.2 - Opret en admin bruger til Employees databasen

Opret en MySQL bruger kaldet `admin_emp` der kan administrere Employees databasen med fulde rettigheder.

**Trin:**
1. Opret brugen med passord `secure_admin_emp`
2. Grant ALL PRIVILEGES på employees databasen
3. Verifikation: Kør `SHOW GRANTS FOR 'admin_emp'@'localhost';`

**Forventet resultat:** Bruger har fulde rettigheder til employees database

---

## Øvelse 6.3 - Begrænset adgang til specifikke tabeller

Opret en bruger `order_viewer` der kun må læse fra `orders` tabellen i Northwind databasen.

**Trin:**
1. Opret brugen med passord `secure_order_view`
2. Grant SELECT privilege kun på `northwind.orders` tabellen
3. Verifikation: Kør `SHOW GRANTS FOR 'order_viewer'@'localhost';`

**Forventet resultat:** Bruger kan se `orders` men ikke andre tabeller

---

## Øvelse 6.4 - Backup kun struktur (DDL)

Lav et backup af Northwind databasen som kun indeholder tabelstrukturen, uden data.

**Kommando:**
```bash
mysqldump -u root -p --no-data northwind > northwind_struktur.sql
```

**Verifikation:**
- Åbn northwind_struktur.sql filen
- Bekræft at den indeholder CREATE TABLE statements
- Bekræft at den IKKE indeholder INSERT statements
- Check filens størrelse (skal være meget mindre end fuld backup)

---

## Øvelse 6.5 - Backup kun data (DML)

Lav et backup af Northwind databasen som kun indeholder data, uden strukturdefinitioner.

**Kommando:**
```bash
mysqldump -u root -p --no-create-info northwind > northwind_data_only.sql
```

**Verifikation:**
- Åbn northwind_data_only.sql filen
- Bekræft at den IKKE indeholder CREATE TABLE statements
- Bekræft at den indeholder INSERT statements
- Check filens størrelse

---

## Øvelse 6.6 - Restore backup til ny database

Opret en ny database kaldet `northwind_restored` og restore data derfra.

**Trin:**
1. Opret ny tom database: `CREATE DATABASE northwind_restored;`
2. Restore strukturen: `mysql -u root -p northwind_restored < northwind_struktur.sql`
3. Restore dataene: `mysql -u root -p northwind_restored < northwind_data_only.sql`
4. Verifikation: Kør `SELECT COUNT(*) FROM northwind_restored.orders;` og sammenlign med original

**Forventet resultat:** northwind_restored indeholder samme data som original northwind databasen

---

## Øvelse 6.7 - Verifikation af brugerrettigheder

Verifikér at dine oprettede brugere har korrekte rettigheder.

**Kommandoer:**
```sql
-- Vis alle MySQL brugere
SELECT user, host FROM mysql.user WHERE user NOT IN ('mysql.sys', 'mysql.session', 'root');

-- Vis rettigheder for hver bruger
SHOW GRANTS FOR 'reader_nw'@'localhost';
SHOW GRANTS FOR 'admin_emp'@'localhost';
SHOW GRANTS FOR 'order_viewer'@'localhost';
```

**Verifikation:**
- Bekræft at hver bruger kun har de rettigheder du tildelte
- Bekræft at DEFAULT passwordexpires ikke er sat
- Forsøg at logge ind som en af brugerne og test deres rettigheder

---

## Øvelse 6.8 - Test brugerrestriktioner

Test at read-only bruger faktisk ikke kan ændre data.

**Trin:**
1. Logind som `reader_nw`:
   ```bash
   mysql -u reader_nw -p northwind
   ```
2. Kør en READ query - det skal fungere:
   ```sql
   SELECT COUNT(*) FROM orders;
   ```
3. Forsøg en WRITE operation - det skal fejle:
   ```sql
   DELETE FROM orders WHERE id = 1;
   ```

**Forventet resultat:** SELECT virker, DELETE fejler med "Access Denied"

---

## Øvelse 6.9 - Backup hele databasen med kompression

Lav et komprimeret backup af begge databaser (Northwind og Employees).

**Kommando:**
```bash
mysqldump -u root -p --databases northwind employees | gzip > all_databases.sql.gz
```

**Verifikation:**
- Check filens størrelse (skal være væsentligt mindre end ukomprimeret)
- Dekompimer filen: `gunzip -c all_databases.sql.gz | head -20`
- Bekræft at begge databasers CREATE DATABASE statements er til stede

---

## Øvelse 6.10 - Fjern brugerrettigheder

Fjern SELECT privilege fra `order_viewer` bruger og bekræft at det virker.

**Trin:**
1. Fjern SELECT rettigheder:
   ```sql
   REVOKE SELECT ON northwind.orders FROM 'order_viewer'@'localhost';
   ```
2. Verifikation:
   ```sql
   SHOW GRANTS FOR 'order_viewer'@'localhost';
   ```
3. Test: Logind som `order_viewer` og forsøg `SELECT * FROM northwind.orders;`

**Forventet resultat:**
- SHOW GRANTS viser ingen rettigheder
- SELECT query fejler med "Access Denied"

---

## Øvelse 6.11 - Slet bruger

Slet brugerene du oprettede i denne øvelsesgang.

**Kommandoer:**
```sql
DROP USER 'reader_nw'@'localhost';
DROP USER 'admin_emp'@'localhost';
DROP USER 'order_viewer'@'localhost';
```

**Verifikation:**
```sql
SELECT user, host FROM mysql.user WHERE user IN ('reader_nw', 'admin_emp', 'order_viewer');
```

**Forventet resultat:** Ingen resultater (brugerne er slettet)

---

## Øvelse 6.12 - Opret automatiseret backup script

Opret et bash script der dagligt laver backup af northwind databasen.

**Script eksempel (backup_daily.sh):**
```bash
#!/bin/bash

BACKUP_DIR="/home/backup/mysql"
DATABASE="northwind"
DATE=$(date +%Y%m%d_%H%M%S)
BACKUP_FILE="$BACKUP_DIR/${DATABASE}_${DATE}.sql"

mkdir -p $BACKUP_DIR

mysqldump -u root -p[PASSWORD] $DATABASE > $BACKUP_FILE

echo "Backup completed: $BACKUP_FILE"
```

**Trin:**
1. Opret scriptet
2. Gør det kørbart: `chmod +x backup_daily.sh`
3. Test det: `./backup_daily.sh`
4. Verifikation: Check at backup filen blev oprettet

---

## Opsummering

Efter disse øvelser skulle du kunne:
- Oprette og administrere MySQL brugere
- Tildele granulære rettigheder baseret på behov
- Lave backups med verschiedene strategier
- Restore data fra backups
- Teste og verifikere sikkerhedsindstillinger
- Automatisere backup processer
