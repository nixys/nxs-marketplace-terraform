# Managed-postgresql

## Introduction

This is a set of terraform modules for the Yandex Cloud provider for building a Managed-postgresql and creating any different postgresql resources

## Features

- Supported postgresql-cluster
- Supported postgresql-database
- Supported postgresql-user with password

## Settings

| Option | Type | Required | Default value |Description |
| --- | ---  | --- | --- | --- |
| `clusters.network_id` | String | Yes | - | ID of the network, to which the PostgreSQL cluster belongs. |
| `clusters.description` | String | No | "Created by Terraform" | Description of the PostgreSQL cluster. |
| `clusters.host_master_name` | String | No | null | It sets name of master host. It works only when host.name is set. |
| `clusters.security_group_ids` | List | No | [] | A set of ids of security groups assigned to hosts of the cluster. |
| `clusters.deletion_protection` | Bool | No | false | Inhibits deletion of the cluster. Can be either true or false. |
| `clusters.restore_backup_id` | String | No | null | Backup ID. The cluster will be created from the specified backup. |
| `clusters.restore_time` | String | No | null | Timestamp of the moment to which the PostgreSQL cluster should be restored. (Format: "2006-01-02T15:04:05" - UTC). When not set, current time is used. |
| `clusters.restore_time_inclusive` | Bool | No | null |  Flag that indicates whether a database should be restored to the first backup point available just after the timestamp specified in the time field instead of just before. |
| `clusters.maintenance_window_type` | String | No | "WEEKLY" | Type of maintenance window. Can be either ANYTIME or WEEKLY. A day and hour of window need to be specified with weekly window. |
| `clusters.maintenance_window_day` | String | No | "WEN" | Day of the week (in DDD format). Allowed values: "MON", "TUE", "WED", "THU", "FRI", "SAT", "SUN". |
| `clusters.maintenance_window_hour` | Int | No | 23 | Hour of the day in UTC (in HH format). Allowed value is between 1 and 24. |
| `clusters.environment` | String | Yes | "PRODUCTION" | Deployment environment of the PostgreSQL cluster. |
| `clusters.disk_size` | Int | Yes | 10 | Volume of the storage available to a PostgreSQL host, in gigabytes. |
| `clusters.disk_type` | String | Yes | "network-hdd" | Type of the storage of PostgreSQL hosts. |
| `clusters.instance_type` | String | Yes | "s2.micro" | The ID of the preset for computational resources available to a PostgreSQL host (CPU, memory etc.). |
| `clusters.postgresql_version` | Int | Yes | 13 | Version of the PostgreSQL cluster. (allowed versions are: 10, 10-1c, 11, 11-1c, 12, 12-1c, 13, 13-1c, 14, 14-1c) |
| `clusters.access_data_lens` | Bool | No | null | Allow access for Yandex DataLens. |
| `clusters.access_web_sql` | Bool | No | null | Allow access for SQL queries in the management console. |
| `clusters.access_serverless` | Bool | No | null | Allow access for connection to managed databases from functions. |
| `clusters.access_data_transfer` | Bool | No | null | Allow access for DataTransfer. |
| `clusters.perfomance_diagnostics_enabled` | Bool | No | false | Enable performance diagnostics. |
| `clusters.sessions_sampling_interval` | Int | No | null | Interval (in seconds) for pg_stat_activity sampling Acceptable values are 1 to 86400, inclusive. |
| `clusters.statements_sampling_interval` | Int | No | null | Interval (in seconds) for pg_stat_statements sampling Acceptable values are 1 to 86400, inclusive. |
| `clusters.disk_size_autoscaling_limit` | Int | No | null | Limit of disk size after autoscaling (GiB). |
| `clusters.disk_size_autoscaling_planned_usage_threshold` | Int | No | null | Maintenance window autoscaling disk usage (percent). |
| `clusters.disk_size_autoscaling_emergency_usage_threshold` | Int | No | null | Immediate autoscaling disk usage (percent). |
| `clusters.autofailover` | Bool | No | null | Configuration setting which enables/disables autofailover in cluster. |
| `clusters.backup_retain_period_days` | Int | No | null | The period in days during which backups are stored. |
| `clusters.backup_window_start_hours` | Int | No | null | The hour at which backup will be started (UTC). |
| `clusters.backup_window_start_minutes` | Int | No | null | The minute at which backup will be started (UTC). |
| `clusters.pooler_config_pool_discard` | Bool | No | null | Setting pool_discard parameter in Odyssey. |
| `clusters.pooler_config_pooling_mode` | String | No | null | Mode that the connection pooler is working in. See descriptions of all modes in the documentation for Odyssey. |
| `clusters.postgresql_config` | Map | No | {} | PostgreSQL cluster config. Detail info in "postresql config" section. |
| `clusters.postgresql_hosts` | List | Yes | - | A host of the PostgreSQL cluster. |
| `clusters.labels` | Map | No | {} | A set of key/value label pairs to assign to the PostgreSQL cluster. |
| `databases.cluster_name` | String | No | - | PostgreSQL cluster name for users. |
| `databases.owner_user` | String | Yes | - | Name of the user assigned as the owner of the database. Forbidden to change in an existing database. |
| `databases.lc_collate` | String | No | "" | POSIX locale for string sorting order. Forbidden to change in an existing database. |
| `databases.lc_type` | String | No | "" | POSIX locale for character classification. Forbidden to change in an existing database. |
| `databases.template_db` | String | No | null | Name of the template database. |
| `databases.deletion_protection` | Bool | No | false | Inhibits deletion of the database. Can either be true, false or unspecified. |
| `databases.extension` | List | No | [] | This block supports name of the database, version and delete_protection. |
| `users.cluster_name` | String | No | - | PostgreSQL cluster name for users. |
| `users.conn_limit` | String | No | null | The maximum number of connections per user. (Default 50) |
| `users.login` | Bool | No | true | User's ability to login. |
| `users.deletion_protection` | Bool | No | false | Inhibits deletion of the user. Can either be true, false or unspecified. |
| `users.grants` | List | No | [] | List of the user's grants. |
| `users.settings` | Map | No | {} | Map of user settings. List of settings is documented below. |

## Example

Usage example located in this [directory](docs/example).
