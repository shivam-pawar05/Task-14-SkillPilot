#!/usr/bin/env bash
set -Eeuo pipefail

if [[ $# -ne 1 ]]; then
  echo "Usage: $0 /path/to/company_demo_YYYYMMDD_HHMMSS.sql.gz" >&2
  exit 2
fi

BACKUP_FILE="$1"
DB_NAME="company_demo"
MYSQL_DEFAULTS_FILE="/etc/mysql/backup-client.cnf"

if [[ ! -f "$BACKUP_FILE" ]]; then
  echo "Backup file not found: $BACKUP_FILE" >&2
  exit 1
fi

read -r -p "Restore into database '$DB_NAME'? This may overwrite data. Type RESTORE to continue: " confirmation
[[ "$confirmation" == "RESTORE" ]] || { echo "Cancelled"; exit 1; }

gzip -dc "$BACKUP_FILE" | mysql --defaults-extra-file="$MYSQL_DEFAULTS_FILE" "$DB_NAME"
echo "Restore command completed. Verify tables and application data."
