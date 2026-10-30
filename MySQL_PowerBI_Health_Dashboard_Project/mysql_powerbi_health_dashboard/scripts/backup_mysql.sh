#!/usr/bin/env bash
set -Eeuo pipefail

# Configure these values for your VM. Use ~/.my.cnf or MYSQL_PWD_FILE for secrets.
DB_NAME="company_demo"
DB_USER="backup_user"
BACKUP_DIR="/var/backups/mysql"
MYSQL_DEFAULTS_FILE="/etc/mysql/backup-client.cnf"
LOG_FILE="${BACKUP_DIR}/backup_status.csv"
RETENTION_DAYS=14

mkdir -p "$BACKUP_DIR"
chmod 750 "$BACKUP_DIR"
timestamp="$(date '+%Y%m%d_%H%M%S')"
backup_file="${BACKUP_DIR}/${DB_NAME}_${timestamp}.sql.gz"

echo "timestamp,backup_file,status,size_bytes,message" >> "$LOG_FILE"

if mysqldump --defaults-extra-file="$MYSQL_DEFAULTS_FILE" \
    --user="$DB_USER" --single-transaction --routines --triggers "$DB_NAME" \
    | gzip > "$backup_file"; then
  size_bytes="$(stat -c%s "$backup_file")"
  echo "$(date --iso-8601=seconds),$backup_file,SUCCESS,$size_bytes,Backup completed" >> "$LOG_FILE"
  echo "Backup completed: $backup_file ($size_bytes bytes)"
else
  rm -f "$backup_file"
  echo "$(date --iso-8601=seconds),$backup_file,FAILED,0,dump or compression failed" >> "$LOG_FILE"
  echo "Backup failed" >&2
  exit 1
fi

find "$BACKUP_DIR" -type f -name "${DB_NAME}_*.sql.gz" -mtime +"$RETENTION_DAYS" -delete
