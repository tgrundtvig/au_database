# Kursusgang 6: Access Control og Backup
1. Access Control 
2. Backup og Restore
3. Eksamensspørgsmålseksempler

## MySQL Access Control System

The MySQL access control has two stages when a client connects to the server:

**Connection verification**

A client, which connects to the MySQL database server, needs to have a valid username and password. In addition, the host from which the client connects has to match with the host in the MySQL grant table.

**Request verification**

Once a connection is established successfully, for each statement issued by the client, MySQL checks whether the client has sufficient privileges to execute that particular statement. MySQL has the ability to check a privilege at the database, table, and field level.

## Database - mysql

There is a database named mysql created automatically by MySQL installer. 

### Following tables are useful to know:
**user**
contains user account and global privileges columns. MySQL uses the user table to either accept or reject a connection from a host. A privilege granted in the user table is effective to all databases on the MySQL server.

**db**
contains database level privileges. MySQL uses the db table to determine which database a user can access and from which host. A privilege granted at the database level in the db table applies to the database and all objects belong to that database e.g., tables, triggers, views, stored procedures, etc.

**table_priv** and **columns_priv**
contains table-level and column-level privileges. A privilege granted in the table_priv table applies to the table and its columns while a privilege granted in the columns_priv table applies only to a specific column of a table.

**procs_priv**
contains stored functions and stored procedures privileges

## Users

In MySQL, you can specify not only who can connect to a database server but also from where. 

Therefore, an account in MySQL consists of username and hostname where the user connects from, that separated by @.

For example, if the root user connects from the cphbusiness.dk host to the database server the account name would be root@cphbusiness.dk.

This allows you to setup multiple accounts with the same name but connects from different hosts and have different privileges.

### Usefull commands
- **CREATE USER** statement is used to create a new user account. The CREATE USER statement requires the CREATE USER privilege: `CREATE USER 'username'@'host' IDENTIFIED BY 'password';`
- **DROP USER** statement is used to delete a user account. The DROP USER statement requires the DROP USER privilege: `DROP USER 'username'@'host';`
- [**GRANT**](https://dev.mysql.com/doc/refman/8.0/en/grant.html) statement is used to grant privileges to a user account. The GRANT statement requires the GRANT OPTION privilege: 
  - `GRANT privilege ON database.table TO 'username'@'host';`
  - `GRANT ALL PRIVILEGES ON *.* TO 'username'@'host';`
  - `GRANT ALL PRIVILEGES ON *.* TO 'dev'@'%' ;`
- **REVOKE** statement is used to revoke privileges from a user account. The REVOKE statement requires the GRANT OPTION privilege.
- **SHOW GRANTS** statement is used to display the privileges granted to a user account. The SHOW GRANTS statement requires the SHOW GRANTS privilege.
  - `SHOW GRANTS FOR 'dev'@'%';`
- **SET PASSWORD** statement is used to set a password for a user account. The SET PASSWORD statement requires the CREATE USER privilege.
- **ALTER USER** statement is used to modify a user account. The ALTER USER statement requires the CREATE USER privilege.
  - `ALTER USER 'username'@'host' IDENTIFIED BY 'password';` Change password
  - `ALTER USER 'username'@'host' COMMENT 'new information';` Change comment
### Grant Privileges to Account

MySQL provides you with the MySQL GRANT statement that allows you to grant access privileges to database accounts.

## Backup - mysqldump
How to Backup Databases Using mysqldump Tool

MySQL GUI tools such as phpMyAdmin, SQLyog and etc, often provide features for backup MySQL databases with ease. 
However if your database is big, the backup process could be very slow because the backup file needs to be transferred across the network to your client PC. 

As the result, the backup process increases the locking and available time of the MySQL database server.

MySQL provides a very useful tool for backup or dump MySQL databases locally on the server very fast. The backup file is stored in the file system in the server so you just need to download it when needed.

### mysqldump Tool
The parameter of the command mysqldump

**username**	valid MySQL username

**password**	valid password for the user

**database_name**	database name you want to backup

**dump_file.sql**	dump file you want to generate

**mysqldump -u root –p classicmodels > classicmodels.sql**

By executing the above command, all database structure and data will be exported into a single **dump_file.sql** dump file.

- Structure Only	--no-data
  - mysqldump -u root -p --no-data classicmodels > classicmodels.sql

- Data Only	--no-create-info
  - mysqldump -u root -p --no-create-info classicmodels > classicmodels.sql

- Flere databaser	--databases databasenavn1 databasenavn2
  - mysqldump -u root -p --databases classicmodels northwind > classi_nord.sql

 - Alle databaser	--all-database
  - mysqldump -u root -p --all-databases > all_db.sql

### Useful commands
*When logged in to the server: `docker exec -it mysql_container bash`* from the command line.
- `mysqldump -u dev -p --all-databases > all_db.sql` Backup all database`
- `mysqldump -u dev -p --databases classicmodels northwind > classi_nord.sql` Backup multiple databases
- `mysql -u dev -p < all_db.sql` restore multiple databases
- `mysql -u dev -p northwind < northwind.sql` restore single database

## Deployment
Eksempel på server: [Digital Ocean](https://www.digitalocean.com/).
- Follow this [guide](https://docs.google.com/document/d/1tY1QKk4CK70iH0abeetCDMgNhKFhR558V9J4_0at-9I/edit?usp=sharing) to deploy your database to a server.
- Setup a MySql Workbench connection to your server using the IP address of your server.
