# Managed-mysql

## Introduction

This is a set of terraform modules for the Yandex Cloud provider for building a Managed-mysql and creating any different mysql resources

## Features

- Supported mysql-cluster
- Supported mysql-database
- Supported mysql-user with password

## Settings

| Option | Type | Required | Default value |Description |
| --- | ---  | --- | --- | --- |
| `clusters.description` | String | No | "Created by Terraform" | Description of the MySQL cluster. |
| `clusters.environment` | String | Yes | "PRODUCTION" | Deployment environment of the MySQL cluster. |
| `clusters.network_id` | String | Yes | - | ID of the network, to which the MySQL cluster uses. |
| `clusters.version` | String | Yes | - | Version of the MySQL cluster. (allowed versions are: 5.7, 8.0) |
| `clusters.backup_retain_period_days` | String | No | null | The period in days during which backups are stored. |
| `clusters.security_group_ids` | List | No | - | A set of ids of security groups assigned to hosts of the cluster. |
| `clusters.deletion_protection` | Bool | No | false | Inhibits deletion of the cluster. Can be either true or false. |
| `clusters.maintenance_window_type` | String | No | "ANYTIME" | Type of maintenance window. Can be either ANYTIME or WEEKLY. A day and hour of window need to be specified with weekly window. |
| `clusters.maintenance_window_day` | String | No | - | Day of the week (in DDD format). Allowed values: "MON", "TUE", "WED", "THU", "FRI", "SAT", "SUN" |
| `clusters.maintenance_window_hour` | Int | No | - | Hour of the day in UTC (in HH format). Allowed value is between 0 and 23. |
| `clusters.resource_preset_id` | String | Yes | - | The ID of the preset for computational resources available to a MySQL host (CPU, memory etc.). |
| `clusters.disk_type` | String | Yes | "network-hdd" | Type of the storage of MySQL hosts. |
| `clusters.disk_size` | Int | Yes | 10 | Volume of the storage available to a MySQL host, in gigabytes. |
| `clusters.backup_window_start_hours` | Int | No | null | The hour at which backup will be started. |
| `clusters.backup_window_start_minutes` | Int | No | null | The minute at which backup will be started. |
| `clusters.mysql_hosts` | List | Yes | - | A list with host of the MySQL cluster |
| `clusters.mysql_config` | Map | No | {} | MySQL cluster config. |
| `clusters.access_data_lens` | Bool | No | false | Allow access for Yandex DataLens. |
| `clusters.access_web_sql` | Bool | No | false | Allows access for SQL queries in the management console. |
| `clusters.access_data_transfer` | Bool | No | false | Allow access for DataTransfer. |
| `clusters.performance_diagnostics_enabled` | Bool | No | false | Enable performance diagnostics |
| `clusters.sessions_sampling_interval` | Int | No | 86400 | Interval (in seconds) for my_stat_activity sampling Acceptable values are 1 to 86400, inclusive. |
| `clusters.statements_sampling_interval` | Int | No | 86400 | Interval (in seconds) for my_stat_statements sampling Acceptable values are 1 to 86400, inclusive. |
| `clusters.labels` | Map | No | {} | A set of key/value label pairs to assign to the MySQL cluster. |
| `users.mysql_cluster_name` | String | No | - | Mysql cluster name for users. |
| `users.permission` | List | No | - | Set of permissions granted to the user. |
| `users.max_questions_per_hour` | Int | No | - | Max questions per hour. |
| `users.max_updates_per_hour` | Int | No | - | Max updates per hour. |
| `users.max_connections_per_hour` | Int | No | - | Max connections per hour. |
| `users.max_user_connections` | Int | No | - | Max user connections. |
| `users.global_permissions` | List | No | [] | List user's global permissions Allowed permissions: REPLICATION_CLIENT, REPLICATION_SLAVE, PROCESS for clear list use empty list. If the attribute is not specified there will be no changes. |
| `users.authentication_plugin` | String | No | "SHA256_PASSWORD" | Authentication plugin. Allowed values: MYSQL_NATIVE_PASSWORD, CACHING_SHA2_PASSWORD, SHA256_PASSWORD (for version 5.7 MYSQL_NATIVE_PASSWORD, SHA256_PASSWORD) |
| `databases.mysql_cluster_name` | String | No | - | Mysql cluster name for users. |

## Example

Usage example located in this [directory](docs/example).
