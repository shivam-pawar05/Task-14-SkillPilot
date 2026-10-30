# MySQL Database Administration & Power BI Health Dashboard

## Project overview
A mini-project that provisions a MySQL database, applies least-privilege role-based access, adds indexes, schedules daily backups, and prepares database health metrics for a Power BI dashboard.

## Project structure
- `sql/01_database_and_tables.sql` — database and sample tables
- `sql/02_roles_and_users.sql` — roles, grants, and example users
- `sql/03_indexes.sql` — performance indexes
- `sql/04_sample_data.sql` — demo data
- `scripts/backup_mysql.sh` — timestamped compressed backup
- `scripts/restore_mysql.sh` — restore helper
- `scripts/collect_health_metrics.sql` — SQL metrics for Power BI
- `powerbi/README.md` — Power BI connection and dashboard instructions
- `config/my.cnf.example` — example client configuration

## Requirements
- MySQL 8.0+
- Linux VM (Ubuntu/Debian recommended) for scheduled backups
- Power BI Desktop
- MySQL connector/driver supported by your Power BI installation

## Setup
1. Install MySQL on your VM and start the service.
2. Create a secure MySQL admin account. Do not use the root account for application access.
3. Run the SQL files in order:
   ```bash
   mysql -u root -p < sql/01_database_and_tables.sql
   mysql -u root -p < sql/02_roles_and_users.sql
   mysql -u root -p < sql/03_indexes.sql
   mysql -u root -p < sql/04_sample_data.sql
   ```
4. Edit `scripts/backup_mysql.sh` and set `DB_USER`, `DB_NAME`, and `BACKUP_DIR`. Prefer a protected MySQL option file over putting passwords in scripts.
5. Make the script executable and test it:
   ```bash
   chmod 750 scripts/backup_mysql.sh
   ./scripts/backup_mysql.sh
   ```
6. Schedule daily backup at 2:00 AM:
   ```bash
   crontab -e
   ```
   Add:
   ```cron
   0 2 * * * /absolute/path/to/scripts/backup_mysql.sh >> /var/log/mysql-backup.log 2>&1
   ```
7. Follow `powerbi/README.md` to connect Power BI and build the health dashboard.

## Security notes
- Replace all demo passwords before using this project.
- Grant only the permissions each user needs.
- Keep backups outside the web root, restrict directory permissions, and test restores.
- For production, use TLS, firewall restrictions, secret management, backup retention, and monitoring.

## Dashboard metrics
The included SQL demonstrates database size, table row estimates, active connections, uptime, and backup status. MySQL server CPU is an OS metric; collect it on the VM (for example with a scheduled script or monitoring agent) and import it into Power BI. The backup script writes a CSV status log that can also be imported.

This is a learning/demo project. The backup script assumes a Linux VM with `mysqldump`, `gzip`, and MySQL client installed.
