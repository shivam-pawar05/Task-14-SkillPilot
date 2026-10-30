# Power BI Health Dashboard

## Connect to MySQL
1. Install the MySQL connector/driver supported by your Power BI Desktop version.
2. In Power BI Desktop, choose **Get Data → MySQL database**.
3. Enter the VM hostname/IP and database `company_demo`.
4. Authenticate with a read-only reporting account. Restrict the account to the database and network source.
5. Import these tables/queries:
   - `employees`
   - `orders`
   - `departments`
   - `backup_log` (if the script is configured to write backup records)
   - Results from `scripts/collect_health_metrics.sql`
6. For a VM that is not on your local network, use a secure gateway/VPN. Do not expose MySQL publicly.

## Dashboard pages and visuals
### Overview
- Card: MySQL uptime (seconds or converted to days)
- Card: current connections
- Card: peak connections
- Card: database size (MB)
- Card: latest backup status
- Line chart: database size by collection time (requires storing periodic metric snapshots)

### Database
- Bar chart: table size (MB) by table
- Table: estimated rows, table size
- Bar chart: orders by status

### Backup monitoring
- Table: timestamp, status, file size, backup file
- Line chart: backup size over time
- KPI: latest successful backup time

## Important data collection note
`collect_health_metrics.sql` returns a point-in-time snapshot. To trend metrics, run it periodically and append results to a monitoring table or CSV. MySQL CPU utilization is an operating-system metric, not a normal SQL status variable; collect it from the VM using a monitoring agent or a scheduled `top`/`mpstat`-based script, then load that CSV into Power BI.

The included backup script logs status to `scripts/backup_status.csv` in its backup directory. Import that CSV in Power BI. The `backup_log` SQL table is provided as an optional destination if you choose to add a database logging step.
