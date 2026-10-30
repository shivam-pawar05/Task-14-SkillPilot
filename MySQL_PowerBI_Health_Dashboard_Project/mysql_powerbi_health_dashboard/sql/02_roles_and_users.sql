-- Run as a MySQL administrator. Replace demo passwords before use.
USE company_demo;

CREATE ROLE IF NOT EXISTS 'app_readonly';
CREATE ROLE IF NOT EXISTS 'app_data_entry';
CREATE ROLE IF NOT EXISTS 'backup_operator';

GRANT SELECT ON company_demo.* TO 'app_readonly';

GRANT SELECT, INSERT, UPDATE ON company_demo.employees TO 'app_data_entry';
GRANT SELECT, INSERT, UPDATE ON company_demo.orders TO 'app_data_entry';
GRANT SELECT ON company_demo.departments TO 'app_data_entry';

GRANT SELECT, LOCK TABLES, SHOW VIEW, EVENT, TRIGGER
  ON company_demo.* TO 'backup_operator';

CREATE USER IF NOT EXISTS 'report_user'@'%' IDENTIFIED BY 'CHANGE_ME_Report_2026!';
CREATE USER IF NOT EXISTS 'data_entry_user'@'%' IDENTIFIED BY 'CHANGE_ME_Entry_2026!';
CREATE USER IF NOT EXISTS 'backup_user'@'localhost' IDENTIFIED BY 'CHANGE_ME_Backup_2026!';

GRANT 'app_readonly' TO 'report_user'@'%';
GRANT 'app_data_entry' TO 'data_entry_user'@'%';
GRANT 'backup_operator' TO 'backup_user'@'localhost';

SET DEFAULT ROLE 'app_readonly' TO 'report_user'@'%';
SET DEFAULT ROLE 'app_data_entry' TO 'data_entry_user'@'%';
SET DEFAULT ROLE 'backup_operator' TO 'backup_user'@'localhost';

-- Verify effective grants:
SHOW GRANTS FOR 'report_user'@'%';
SHOW GRANTS FOR 'data_entry_user'@'%';
