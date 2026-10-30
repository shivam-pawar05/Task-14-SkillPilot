-- Run in MySQL Workbench or with the MySQL CLI.
-- Some values are server-wide and require suitable monitoring privileges.

SELECT NOW() AS collected_at,
       @@hostname AS server_name,
       @@version AS mysql_version,
       (SELECT VARIABLE_VALUE FROM performance_schema.global_status
         WHERE VARIABLE_NAME='UPTIME') AS uptime_seconds,
       (SELECT VARIABLE_VALUE FROM performance_schema.global_status
         WHERE VARIABLE_NAME='THREADS_CONNECTED') AS current_connections,
       (SELECT VARIABLE_VALUE FROM performance_schema.global_status
         WHERE VARIABLE_NAME='MAX_USED_CONNECTIONS') AS peak_connections,
       (SELECT ROUND(SUM(data_length+index_length)/1024/1024,2)
          FROM information_schema.tables
         WHERE table_schema='company_demo') AS database_size_mb;

-- Table-level size and estimated rows:
SELECT table_name,
       table_rows AS estimated_rows,
       ROUND((data_length+index_length)/1024/1024,2) AS size_mb
FROM information_schema.tables
WHERE table_schema='company_demo'
ORDER BY size_mb DESC;

-- Backup status:
SELECT backup_time, status, file_size_bytes, backup_file, message
FROM company_demo.backup_log
ORDER BY backup_time DESC;
