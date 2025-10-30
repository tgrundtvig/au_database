-- Opgave 6: Sikkerhed og Backup - SQL Solutions
--
-- NOTE: Some exercises require bash/system commands that cannot be run in pure SQL.
-- These are documented below for reference.

-- =====================================================
-- 6.1: Opret en read-only bruger til Northwind
-- =====================================================

-- Create read-only user
CREATE USER 'reader_nw'@'localhost' IDENTIFIED BY 'secure_read_nw';

-- Grant only SELECT privilege on northwind database
GRANT SELECT ON northwind.* TO 'reader_nw'@'localhost';

-- Flush privileges to apply changes immediately
FLUSH PRIVILEGES;

-- Verification
SHOW GRANTS FOR 'reader_nw'@'localhost';
-- Expected output:
-- GRANT USAGE ON *.* TO 'reader_nw'@'localhost'
-- GRANT SELECT ON `northwind`.* TO 'reader_nw'@'localhost'


-- =====================================================
-- 6.2: Opret en admin bruger til Employees databasen
-- =====================================================

-- Create admin user for employees database
CREATE USER 'admin_emp'@'localhost' IDENTIFIED BY 'secure_admin_emp';

-- Grant ALL PRIVILEGES on employees database
GRANT ALL PRIVILEGES ON employees.* TO 'admin_emp'@'localhost';

-- Flush privileges
FLUSH PRIVILEGES;

-- Verification
SHOW GRANTS FOR 'admin_emp'@'localhost';
-- Expected output:
-- GRANT USAGE ON *.* TO 'admin_emp'@'localhost'
-- GRANT ALL PRIVILEGES ON `employees`.* TO 'admin_emp'@'localhost'


-- =====================================================
-- 6.3: Begrænset adgang til specifikke tabeller
-- =====================================================

-- Create table-specific user
CREATE USER 'order_viewer'@'localhost' IDENTIFIED BY 'secure_order_view';

-- Grant SELECT only on orders table in northwind
GRANT SELECT ON northwind.orders TO 'order_viewer'@'localhost';

-- Flush privileges
FLUSH PRIVILEGES;

-- Verification
SHOW GRANTS FOR 'order_viewer'@'localhost';
-- Expected output:
-- GRANT USAGE ON *.* TO 'order_viewer'@'localhost'
-- GRANT SELECT ON `northwind`.`orders` TO 'order_viewer'@'localhost'


-- =====================================================
-- 6.4: Backup kun struktur (DDL)
-- =====================================================

-- This exercise requires bash command line execution:
-- mysqldump -u root -p --no-data northwind > northwind_struktur.sql
--
-- This creates a backup with only CREATE TABLE statements, no INSERT data.
-- The file will be much smaller than a full backup.


-- =====================================================
-- 6.5: Backup kun data (DML)
-- =====================================================

-- This exercise requires bash command line execution:
-- mysqldump -u root -p --no-create-info northwind > northwind_data_only.sql
--
-- This creates a backup with only INSERT statements, no CREATE TABLE definitions.


-- =====================================================
-- 6.6: Restore backup til ny database
-- =====================================================

-- Step 1: Create new database
CREATE DATABASE IF NOT EXISTS northwind_restored;

-- Step 2: Restore structure (bash command):
-- mysql -u root -p northwind_restored < northwind_struktur.sql

-- Step 3: Restore data (bash command):
-- mysql -u root -p northwind_restored < northwind_data_only.sql

-- Step 4: Verification - compare record counts with original
-- Check if same number of records:
SELECT COUNT(*) as original_orders FROM northwind.orders;
SELECT COUNT(*) as restored_orders FROM northwind_restored.orders;

-- Expected: Both queries return same count


-- =====================================================
-- 6.7: Verifikation af brugerrettigheder
-- =====================================================

-- View all non-system users
SELECT user, host FROM mysql.user
WHERE user NOT IN ('mysql.sys', 'mysql.session', 'root');

-- Verify each user's grants
SHOW GRANTS FOR 'reader_nw'@'localhost';
SHOW GRANTS FOR 'admin_emp'@'localhost';
SHOW GRANTS FOR 'order_viewer'@'localhost';

-- Expected outputs:
-- reader_nw: SELECT on northwind.*
-- admin_emp: ALL PRIVILEGES on employees.*
-- order_viewer: SELECT on northwind.orders


-- =====================================================
-- 6.8: Test brugerrestriktioner
-- =====================================================

-- This exercise requires testing from the command line as the specific user:
--
-- Test as reader_nw:
-- mysql -u reader_nw -p northwind
--
-- Then run:
-- SELECT COUNT(*) FROM orders;       -- Should work (returns row count)
-- DELETE FROM orders WHERE id = 1;   -- Should fail with Access Denied
--
-- Expected: SELECT works, DELETE fails with Access Denied error


-- =====================================================
-- 6.9: Backup hele databasen med kompression
-- =====================================================

-- This exercise requires bash command line execution:
-- mysqldump -u root -p --databases northwind employees | gzip > all_databases.sql.gz
--
-- Verification commands:
-- gunzip -c all_databases.sql.gz | head -20
-- ls -lh all_databases.sql.gz     -- Check compressed file size


-- =====================================================
-- 6.10: Fjern brugerrettigheder
-- =====================================================

-- Revoke SELECT privilege from order_viewer
REVOKE SELECT ON northwind.orders FROM 'order_viewer'@'localhost';

-- Flush privileges
FLUSH PRIVILEGES;

-- Verification - should show no grants
SHOW GRANTS FOR 'order_viewer'@'localhost';
-- Expected output:
-- GRANT USAGE ON *.* TO 'order_viewer'@'localhost'
-- (No specific privilege grants)

-- Test: Try to select as order_viewer (from command line):
-- mysql -u order_viewer -p northwind
-- SELECT * FROM orders;  -- Should fail with Access Denied


-- =====================================================
-- 6.11: Slet bruger
-- =====================================================

-- Drop all users created in this exercise set
DROP USER 'reader_nw'@'localhost';
DROP USER 'admin_emp'@'localhost';
DROP USER 'order_viewer'@'localhost';

-- Flush privileges
FLUSH PRIVILEGES;

-- Verification - should return no results
SELECT user, host FROM mysql.user
WHERE user IN ('reader_nw', 'admin_emp', 'order_viewer');
-- Expected: No results (users are deleted)


-- =====================================================
-- 6.12: Opret automatiseret backup script
-- =====================================================

-- This exercise requires creating a bash script, not SQL.
--
-- Example script (backup_daily.sh):
-- #!/bin/bash
-- BACKUP_DIR="/home/backup/mysql"
-- DATABASE="northwind"
-- DATE=$(date +%Y%m%d_%H%M%S)
-- BACKUP_FILE="$BACKUP_DIR/${DATABASE}_${DATE}.sql"
--
-- mkdir -p $BACKUP_DIR
-- mysqldump -u root -p[PASSWORD] $DATABASE > $BACKUP_FILE
-- echo "Backup completed: $BACKUP_FILE"
--
-- To make executable: chmod +x backup_daily.sh
-- To run: ./backup_daily.sh
-- To schedule with cron (daily at 2am):
-- 0 2 * * * /path/to/backup_daily.sh


-- =====================================================
-- Summary of Key SQL Commands Used
-- =====================================================

-- User creation:
-- CREATE USER 'username'@'host' IDENTIFIED BY 'password';

-- Grant permissions (various levels):
-- GRANT SELECT ON northwind.* TO 'username'@'localhost';           -- All tables in database
-- GRANT ALL PRIVILEGES ON employees.* TO 'username'@'localhost';  -- All privileges on database
-- GRANT SELECT ON northwind.orders TO 'username'@'localhost';     -- Specific table only

-- View user grants:
-- SHOW GRANTS FOR 'username'@'localhost';

-- Revoke permissions:
-- REVOKE SELECT ON northwind.orders FROM 'username'@'localhost';

-- Drop users:
-- DROP USER 'username'@'localhost';

-- Refresh privilege tables:
-- FLUSH PRIVILEGES;


-- =====================================================
-- Notes for Students
-- =====================================================

-- Week 6 focuses on security and backup operations which span both SQL and system administration.
--
-- SQL-based exercises:
-- - User creation and management
-- - Permission granting and revoking
-- - Verification of user privileges
--
-- System-based exercises (bash/command line):
-- - mysqldump backups (structure, data, compressed)
-- - Restore operations
-- - Automated backup scripts
-- - User login testing
--
-- All operations in this week are important for production database administration.
-- Proper user management and backup strategies are critical for database security and disaster recovery.
