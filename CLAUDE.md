# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a teaching repository for Aarhus University (AU) Database Course, containing course materials, SQL examples, and sample databases for a MySQL-based database course. The course is taught in Danish and covers fundamental database concepts from basic SQL to advanced topics like stored procedures, triggers, and security.

## MySQL Environment

**Required MySQL Version**: 8.4.6 LTS (Community Server)

**Required Tools**:
- MySQL Community Server 8.4.6 LTS
- MySQL Workbench (latest version)

**Installation Guide**:
- See `docs/00_install.md` for links to official MySQL installation guides
- Official MySQL documentation: https://dev.mysql.com/doc/

## Sample Databases

The course uses two main sample databases located in `docs/sql/samples/`:

1. **Northwind** (`northwind.sql` + `northwind-data.sql`)
   - Microsoft's classic demo database with 13 tables
   - Contains customers, orders, products, employees, etc.
   - ER-diagram available in `docs/images/ER_Northwind.png`

2. **Employees** (`employees.sql`)
   - MySQL official demo database
   - Approximately 160MB with 4 million records across 6 tables
   - ER-diagram available in `docs/images/SampleEmployees.png`

**Loading Databases**:
```sql
-- Northwind
source docs/sql/samples/northwind.sql;
source docs/sql/samples/northwind-data.sql;

-- Employees
source docs/sql/samples/employees.sql;
```

## Repository Structure

```
/docs/
  ├── 01-07_Kursusgang.md     # Weekly lesson materials (Kursusgang = course session)
  ├── 0X_opgave.md            # Weekly exercises (opgave = assignment)
  ├── 07_MiniProjekt.md       # Final exam project requirements
  ├── external_resources/     # Local copies of external documentation
  │   ├── employee-en.a4.pdf  # MySQL official Employees database docs
  │   ├── MySQL_Security_Best_Practices.md  # Security guide (local copy)
  │   └── README.md           # Documentation of available resources
  ├── sql/                    # SQL example files
  │   ├── samples/            # Sample databases (Northwind, Employees)
  │   │   ├── northwind.sql
  │   │   ├── northwind-data.sql
  │   │   ├── employees.sql
  │   │   └── load_*.dump     # Employee data files
  │   ├── Northwind/          # Northwind related files
  │   │   ├── Northwind.sql
  │   │   └── Northwind.pdf   # ER diagram PDF
  │   ├── Dag_3.sql           # Day 3 examples
  │   ├── Dag_4.sql           # Day 4 examples
  │   ├── Dag_5.sql           # Day 5 examples
  │   ├── Skole.sql           # School normalization example
  │   └── postnummer.csv      # Postal codes for CSV import exercises
  ├── images/                 # ER diagrams and screenshots
  │   ├── ER_Northwind.png
  │   ├── SampleEmployees.png
  │   ├── Skole_NF0-3.png     # Normalization progression
  │   └── [various tutorial images]
  └── Opgave_*.pdf            # Assignment PDFs
```

## Course Structure

The course follows a 7-week structure (see `docs/README.md`):

1. **Week 1**: Installation, SELECT queries, WHERE, ORDER BY, DISTINCT
2. **Week 2**: DDL (CREATE DATABASE/TABLE), datatypes, INSERT, UPDATE, DELETE
3. **Week 3**: Normalization (1NF, 2NF, 3NF), JOINs (INNER, LEFT, RIGHT), VIEWs
4. **Week 4**: Functions (AVG, MIN, MAX, COUNT, SUM), GROUP BY, HAVING, INDEX, CASE
5. **Week 5**: Stored Procedures, Triggers, Transactions, CSV Import/Export
6. **Week 6**: Security, User management, Backup with mysqldump
7. **Week 7**: Exam preparation with mini-project presentation

## Working with SQL Files

When working with SQL examples in `docs/sql/`:
- Files are named by day (Dag_X.sql) or topic (Skole.sql)
- Execute in MySQL Workbench or via command line
- Most examples use the Northwind database

**Example files**:
- `Dag_3.sql`: Normalization and JOIN examples
- `Dag_4.sql`: Functions, GROUP BY, INDEX examples
- `Dag_5.sql`: Stored Procedures and Triggers
- `Skole.sql`: Complete normalization example (School database)

## Key MySQL Concepts Covered

### Normalization
The course emphasizes normalization up to 3rd normal form (3NF). Key example: School database in `docs/sql/Skole.sql` demonstrates progression from NF0 to NF3.

**Normalization Rule**: "The key, the whole key, and nothing but the key, so help me Codd."

### Stored Procedures
Uses DELIMITER pattern for MySQL:
```sql
DELIMITER $$
CREATE PROCEDURE procedure_name(param_type INT)
BEGIN
    -- SQL code here
END $$
DELIMITER ;
```

### Triggers
Triggers are stored "under" tables and fire on INSERT, UPDATE, or DELETE:
```sql
DELIMITER $$
CREATE TRIGGER trigger_name
    BEFORE/AFTER INSERT/UPDATE/DELETE ON table_name
    FOR EACH ROW
BEGIN
    -- SQL code using OLD.field or NEW.field
END $$
DELIMITER ;
```

### User Management and Security
Course covers MySQL user administration:
```sql
CREATE USER 'username'@'host' IDENTIFIED BY 'password';
GRANT privilege ON database.table TO 'username'@'host';
SHOW GRANTS FOR 'username'@'host';
```

### Backup Commands
Using mysqldump:
```bash
# Full database backup
mysqldump -u root -p database_name > backup.sql

# Structure only
mysqldump -u root -p --no-data database_name > structure.sql

# Data only
mysqldump -u root -p --no-create-info database_name > data.sql
```

## Exam Project (Mini Projekt)

Students create their own database project covering all course topics. See `docs/07_MiniProjekt.md` for requirements.

**Required deliverables**:
- ER diagram (3 printed copies for exam)
- Database with normalization to 3NF
- Stored procedures
- Triggers
- Index strategy
- User security implementation

**Exam format**: 30-minute oral exam based on student's database project

## Local Resources

The repository includes local copies of external resources in `docs/external_resources/`:

- **employee-en.a4.pdf**: MySQL official documentation for Employees database
- **MySQL_Security_Best_Practices.md**: Comprehensive MySQL security guide covering common threats and best practices

**Note**: Some historical Dropbox links in older documentation are no longer active, but equivalent resources exist locally:
- Northwind ER diagram: `docs/sql/Northwind/Northwind.pdf` and `docs/images/ER_Northwind.png`
- Employees ER diagram: `docs/images/SampleEmployees.png`

**Missing Resource**: `MySQL_Data_Types.pdf` is referenced in `docs/02_Kursusgang.md` but not found in the repository. Use the official MySQL documentation: https://dev.mysql.com/doc/refman/8.0/en/data-types.html

## Important Notes

- All course materials are in Danish
- MySQL 8.4.6 LTS is the required version (not earlier 8.0.x versions)
- Connection defaults: host `127.0.0.1`, port `3306`, user `root`
- CSV import exercises use `docs/sql/postnummer.csv`
- ER diagrams are available as PNG images in `docs/images/` and some as PDFs in respective directories
