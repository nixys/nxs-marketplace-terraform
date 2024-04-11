# SQL

## Introduction

This is a set of terraform modules for the Google Cloud Platform provider for building a SQL and creating any different database's resources

## Features

- Supported databases
- Supported databases's instances
- Supported source representation instances
- Supported ssl certs
- Supported database's users

## Settings

| Option | Type | Required | Default value |Description |
| --- | ---  | --- | --- | --- |
| `databases.instance` | String | Yes | - | The name of the Cloud SQL instance. This does not include the project ID. |
| `databases.charset` | String | No | null | The charset value. See MySQL's Supported Character Sets and Collations and Postgres' Character Set Support for more details and supported values. Postgres databases only support a value of UTF8 at creation time. |
| `databases.collation` | String | No | null | The collation value. See MySQL's Supported Character Sets and Collations and Postgres' Collation Support for more details and supported values. Postgres databases only support a value of en_US.UTF8 at creation time. |
| `databases.project` | String | No | null | The ID of the project in which the resource belongs. If it is not provided, the provider project is used. |
| `databases.deletion_policy` | String | No | "DELETE" |  The deletion policy for the database. Setting ABANDON allows the resource to be abandoned rather than deleted. This is useful for Postgres, where databases cannot be deleted from the API if there are users other than cloudsqlsuperuser with access. Possible values are: "ABANDON", "DELETE". Defaults to "DELETE". |
| `database_instances.region` | String | No | null | The region the instance will sit in. If a region is not provided in the resource definition, the provider region will be used instead. |
| `database_instances.project` | String | No | null | The ID of the project in which the resource belongs. If it is not provided, the provider project is used. |
| `database_instances.database_version` | String | Yes | - | The MySQL, PostgreSQL or SQL Server version to use. Supported values include MYSQL_5_6, MYSQL_5_7, MYSQL_8_0, POSTGRES_9_6,POSTGRES_10, POSTGRES_11, POSTGRES_12, POSTGRES_13, POSTGRES_14, POSTGRES_15, SQLSERVER_2017_STANDARD, SQLSERVER_2017_ENTERPRISE, SQLSERVER_2017_EXPRESS, SQLSERVER_2017_WEB. SQLSERVER_2019_STANDARD, SQLSERVER_2019_ENTERPRISE, SQLSERVER_2019_EXPRESS, SQLSERVER_2019_WEB. Database Version Policies includes an up-to-date reference of supported versions. |
| `database_instances.maintenance_version` | String | No | null | The current software version on the instance. This attribute can not be set during creation. Refer to available_maintenance_versions attribute to see what maintenance_version are available for upgrade. When this attribute gets updated, it will cause an instance restart. Setting a maintenance_version value that is older than the current one on the instance will be ignored. |
| `database_instances.master_instance_name` | String | No | null | The name of the existing instance that will act as the master in the replication setup. Note, this requires the master to have binary_log_enabled set, as well as existing backups. |
| `database_instances.root_password` | String | No | null | Initial root password. Can be updated. Required for MS SQL Server. |
| `database_instances.encryption_key_name` | String | No | null | The full path to the encryption key used for the CMEK disk encryption. Setting up disk encryption currently requires manual steps outside of Terraform. The provided key must be in the same region as the SQL instance. In order to use this feature, a special kind of service account must be created and granted permission on this key. This step can currently only be done manually, please see this step. That service account needs the Cloud KMS > Cloud KMS CryptoKey Encrypter/Decrypter role on your key - please see this step. |
| `database_instances.deletion_protection` | Bool | No | null | Whether or not to allow Terraform to destroy the instance. Unless this field is set to false in Terraform state, a terraform destroy or terraform apply command that deletes the instance will fail. Defaults to true. |
| `database_instances.settings` | List | No | [] | The settings to use for the database. Required if clone is not set. |
| `database_instances.settings.tier` | String | Yes | - | The machine type to use. See tiers for more details and supported versions. Postgres supports only shared-core machine types, and custom machine types such as db-custom-2-13312. See the Custom Machine Type Documentation to learn about specifying custom machine types. |
| `database_instances.settings.edition` | String | No | null | The edition of the instance, can be ENTERPRISE or ENTERPRISE_PLUS. |
| `database_instances.settings.user_labels` | Map | No | {} | A set of key/value user label pairs to assign to the instance. |
| `database_instances.settings.activation_policy` | String | No | null | This specifies when the instance should be active. Can be either ALWAYS, NEVER or ON_DEMAND. |
| `database_instances.settings.availability_type` | String | No | null | The availability type of the Cloud SQL instance, high availability (REGIONAL) or single zone (ZONAL).' For all instances, ensure that settings.backup_configuration.enabled is set to true. For MySQL instances, ensure that settings.backup_configuration.binary_log_enabled is set to true. For Postgres and SQL Server instances, ensure that settings.backup_configuration.point_in_time_recovery_enabled is set to true. Defaults to ZONAL. |
| `database_instances.settings.collation` | String | No | null | The name of server instance collation. |
| `database_instances.settings.connector_enforcement` | String | No | null | Specifies if connections must use Cloud SQL connectors. |
| `database_instances.settings.deletion_protection_enabled` | Bool | No | null | Enables deletion protection of an instance at the GCP level. Enabling this protection will guard against accidental deletion across all surfaces (API, gcloud, Cloud Console and Terraform) by enabling the GCP Cloud SQL instance deletion protection. Terraform provider support was introduced in version 4.48.0. Defaults to false. |
| `database_instances.settings.disk_autoresize` | Bool | No | null | Enables auto-resizing of the storage size. Defaults to true. |
| `database_instances.settings.disk_autoresize_limit` | Int | No | null | The maximum size to which storage capacity can be automatically increased. The default value is 0, which specifies that there is no limit. |
| `database_instances.settings.disk_size` | Int | No | null | The size of data disk, in GB. Size of a running instance cannot be reduced but can be increased. The minimum value is 10GB. |
| `database_instances.settings.disk_type` | String | No | null | The type of data disk: PD_SSD or PD_HDD. Defaults to PD_SSD. |
| `database_instances.settings.pricing_plan` | String | No | null | Pricing plan for this instance, can only be PER_USE. |
| `database_instances.settings.time_zone` | String | No | null | The time_zone to be used by the database engine (supported only for SQL Server), in SQL Server timezone format. |
| `database_instances.settings.advanced_machine_features` | List | No | [] | Block describing advanced_machine_features. |
| `database_instances.settings.advanced_machine_features.threads_per_core` | Int | Yes | - | The number of threads per core. The value of this flag can be 1 or 2. To disable SMT, set this flag to 1. Only available in Cloud SQL for SQL Server instances. See smt for more details. |
| `database_instances.settings.database_flags` | List | No | [] | Block describing database_flags. |
| `database_instances.settings.database_flags.name` | String | Yes | - | Name of the flag. |
| `database_instances.settings.database_flags.value` | String | Yes | - | Value of the flag. |
| `database_instances.settings.active_directory_config` | List | No | [] | Block describing active_directory_config. |
| `database_instances.settings.active_directory_config.domain` | String | Yes | - | The domain name for the active directory (e.g., mydomain.com). Can only be used with SQL Server. |
| `database_instances.settings.data_cache_config` | List | No | [] | Block describing data_cache_config. |
| `database_instances.settings.data_cache_config.data_cache_enabled` | Bool | No | false | Whether data cache is enabled for the instance. Defaults to false. Can be used with MYSQL and PostgreSQL only. |
| `database_instances.settings.deny_maintenance_period` | List | No | [] | Block describing deny_maintenance_period. |
| `database_instances.settings.deny_maintenance_period.end_date` | String | Yes | - | "deny maintenance period" end date. If the year of the end date is empty, the year of the start date also must be empty. In this case, it means the no maintenance interval recurs every year. The date is in format yyyy-mm-dd i.e., 2020-11-01, or mm-dd, i.e., 11-01 |
| `database_instances.settings.deny_maintenance_period.start_date` | String | Yes | - | "deny maintenance period" start date. If the year of the start date is empty, the year of the end date also must be empty. In this case, it means the deny maintenance period recurs every year. The date is in format yyyy-mm-dd i.e., 2020-11-01, or mm-dd, i.e., 11-01 |
| `database_instances.settings.deny_maintenance_period.time` | String | Yes | - | Time in UTC when the "deny maintenance period" starts on startDate and ends on endDate. The time is in format: HH:mm:SS, i.e., 00:00:00 |
| `database_instances.settings.sql_server_audit_config` | List | No | [] | Block describing sql_server_audit_config. |
| `database_instances.settings.sql_server_audit_config.bucket` | String | No | null | The name of the destination bucket (e.g., gs://mybucket). |
| `database_instances.settings.sql_server_audit_config.upload_interval` | String | No | null | How often to upload generated audit files. A duration in seconds with up to nine fractional digits, terminated by 's'. Example: "3.5s". |
| `database_instances.settings.sql_server_audit_config.retention_interval` | String | No | null | How long to keep generated audit files. A duration in seconds with up to nine fractional digits, terminated by 's'. Example: "3.5s".|
| `database_instances.settings.backup_configuration` | List | No | [] | Block describing backup_configuration. |
| `database_instances.settings.backup_configuration.binary_log_enabled` | Bool | No | null | True if binary logging is enabled. Can only be used with MySQL. |
| `database_instances.settings.backup_configuration.enabled` | Bool | No | null | True if backup configuration is enabled. |
| `database_instances.settings.backup_configuration.start_time` | String | No | null | HH:MM format time indicating when backup configuration starts. |
| `database_instances.settings.backup_configuration.point_in_time_recovery_enabled` | Bool | No | null | True if Point-in-time recovery is enabled. Will restart database if enabled after instance creation. Valid only for PostgreSQL and SQL Server instances. |
| `database_instances.settings.backup_configuration.location` | String | No | null | he region where the backup will be stored |
| `database_instances.settings.backup_configuration.transaction_log_retention_days` | Int | No | null | The number of days of transaction logs we retain for point in time restore, from 1-7. For PostgreSQL Enterprise Plus instances, the number of days of retained transaction logs can be set from 1 to 35. |
| `database_instances.settings.backup_configuration.backup_retention_settings` | List | No | [] | Backup retention settings. The configuration is detailed below. |
| `database_instances.settings.backup_configuration.backup_retention_settings.retained_backups` | Int | No | null | Depending on the value of retention_unit, this is used to determine if a backup needs to be deleted. If retention_unit is 'COUNT', we will retain this many backups. |
| `database_instances.settings.backup_configuration.backup_retention_settings.retention_unit` | String | No | null | The unit that 'retained_backups' represents. Defaults to COUNT. |
| `database_instances.settings.ip_configuration` | List | No | [] | Block describing ip_configuration. |
| `database_instances.settings.ip_configuration.ipv4_enabled` | Bool | No | null | Whether this Cloud SQL instance should be assigned a public IPV4 address. At least ipv4_enabled must be enabled or a private_network must be configured. |
| `database_instances.settings.ip_configuration.private_network` | String | No | null | The VPC network from which the Cloud SQL instance is accessible for private IP. For example, projects/myProject/global/networks/default. Specifying a network enables private IP. At least ipv4_enabled must be enabled or a private_network must be configured. This setting can be updated, but it cannot be removed after it is set. |
| `database_instances.settings.ip_configuration.require_ssl` | Bool | No | null | Whether SSL connections over IP are enforced or not. To change this field, also set the corresponding value in ssl_mode. |
| `database_instances.settings.ip_configuration.ssl_mode` | String | No | null | Specify how SSL connection should be enforced in DB connections. This field provides more SSL enforcment options compared to require_ssl. To change this field, also set the correspoding value in require_ssl. |
| `database_instances.settings.ip_configuration.allocated_ip_range` | String | No | null | The name of the allocated ip range for the private ip CloudSQL instance. For example: "google-managed-services-default". If set, the instance ip will be created in the allocated range. The range name must comply with RFC 1035. Specifically, the name must be 1-63 characters long and match the regular expression a-z?. |
| `database_instances.settings.ip_configuration.enable_private_path_for_google_cloud_services` | Bool | No | null | Whether Google Cloud services such as BigQuery are allowed to access data in this Cloud SQL instance over a private IP connection. SQLSERVER database type is not supported. |
| `database_instances.settings.ip_configuration.authorized_networks` | List | No | [] | Block describing authorized_networks. |
| `database_instances.settings.ip_configuration.authorized_networks.expiration_time` | String | No | null | The RFC 3339 formatted date time string indicating when this whitelist expires. |
| `database_instances.settings.ip_configuration.authorized_networks.name` | String | No | null | A name for this whitelist entry. |
| `database_instances.settings.ip_configuration.authorized_networks.value` | String | Yes | - | A CIDR notation IPv4 or IPv6 address that is allowed to access this instance. Must be set even if other two attributes are not for the whitelist to become active. |
| `database_instances.settings.ip_configuration.psc_config` | List | No | [] | Block describing psc_config. |
| `database_instances.settings.ip_configuration.psc_config.psc_enabled` | Bool | No | null | Whether PSC connectivity is enabled for this instance. |
| `database_instances.settings.ip_configuration.psc_config.allowed_consumer_projects` | List | No | [] | List of consumer projects that are allow-listed for PSC connections to this instance. This instance can be connected to with PSC from any network in these projects. Each consumer project in this list may be represented by a project number (numeric) or by a project id (alphanumeric). |
| `database_instances.settings.location_preference` | List | No | [] | Block describing location_preference. |
| `database_instances.settings.location_preference.follow_gae_application` | String | No | null | A GAE application whose zone to remain in. Must be in the same region as this instance. |
| `database_instances.settings.location_preference.zone` | String | No | null | The preferred compute engine zone. |
| `database_instances.settings.location_preference.secondary_zone` | String | No | null | The preferred Compute Engine zone for the secondary/failover. |
| `database_instances.settings.maintenance_window` | List | No | [] | Subblock for instances declares a one-hour maintenance window when an Instance can automatically restart to apply updates. The maintenance window is specified in UTC time. |
| `database_instances.settings.maintenance_window.day` | Int | No | null | Day of week (1-7), starting on Monday |
| `database_instances.settings.maintenance_window.hour` | Int | No | null | Hour of day (0-23), ignored if day not set. |
| `database_instances.settings.maintenance_window.update_track` | String | No | null | Receive updates earlier (canary) or later (stable). |
| `database_instances.settings.insights_config` | List | No | [] | Subblock for instances declares Query Insights(MySQL, PostgreSQL) configuration.  |
| `database_instances.settings.insights_config.query_insights_enabled` | Bool | No | null | True if Query Insights feature is enabled. |
| `database_instances.settings.insights_config.query_string_length` | Int | No | null | Maximum query length stored in bytes. Between 256 and 4500. Default to 1024. Higher query lengths are more useful for analytical queries, but they also require more memory. Changing the query length requires you to restart the instance. You can still add tags to queries that exceed the length limit. |
| `database_instances.settings.insights_config.record_application_tags` | Bool | No | null | True if Query Insights will record application tags from query when enabled. |
| `database_instances.settings.insights_config.record_client_address` | Bool | No | null | True if Query Insights will record client address when enabled. |
| `database_instances.settings.insights_config.query_plans_per_minute` | Int | No | null | Number of query execution plans captured by Insights per minute for all queries combined. Between 0 and 20. Default to 5. |
| `database_instances.settings.password_validation_policy` | List | No | [] | Subblock for instances declares Password Validation Policy configuration. |
| `database_instances.settings.password_validation_policy.min_length` | Int | No | null | Specifies the minimum number of characters that the password must have. |
| `database_instances.settings.password_validation_policy.complexity` | Bool | No | null | Checks if the password is a combination of lowercase, uppercase, numeric, and non-alphanumeric characters. |
| `database_instances.settings.password_validation_policy.reuse_interval` | Int | No | null | Specifies the number of previous passwords that you can't reuse. |
| `database_instances.settings.password_validation_policy.disallow_username_substring` | Bool | No | null | Prevents the use of the username in the password. |
| `database_instances.settings.password_validation_policy.password_change_interval` | Int | No | null | Specifies the minimum duration after which you can change the password. |
| `database_instances.settings.password_validation_policy.enable_password_policy` | Bool | No | null | Enables or disable the password validation policy. |
| `database_instances.replica_configuration` | List | No | [] | The configuration for replication. Valid only for MySQL instances. |
| `database_instances.replica_configuration.ca_certificate` | String | No | null | PEM representation of the trusted CA's x509 certificate. |
| `database_instances.replica_configuration.client_certificate` | String | No | null | PEM representation of the replica's x509 certificate. |
| `database_instances.replica_configuration.client_key` | String | No | null | PEM representation of the replica's private key. The corresponding public key in encoded in the client_certificate. |
| `database_instances.replica_configuration.connect_retry_interval` | Int | No | null | The number of seconds between connect retries. MySQL's default is 60 seconds. |
| `database_instances.replica_configuration.dump_file_path` | Strings | No | null | Path to a SQL file in GCS from which replica instances are created. Format is gs://bucket/filename. |
| `database_instances.replica_configuration.failover_target` | String | No | null | Specifies if the replica is the failover target. If the field is set to true the replica will be designated as a failover replica. If the master instance fails, the replica instance will be promoted as the new master instance. ~> NOTE: Not supported for Postgres database. |
| `database_instances.replica_configuration.master_heartbeat_period` | Int | No | null | Time in ms between replication heartbeats. |
| `database_instances.replica_configuration.password` | String | No | null | Password for the replication connection. |
| `database_instances.replica_configuration.ssl_cipher` | String | No | null | Permissible ciphers for use in SSL encryption. |
| `database_instances.replica_configuration.username` | String | No | null | Username for replication connection. |
| `database_instances.replica_configuration.verify_server_certificate` | Bool | No | null | True if the master's common name value is checked during the SSL handshake. |
| `database_instances.clone` | List | No | [] | Block describing clone. |
| `database_instances.clone.source_instance_name` | String | Yes | - | Name of the source instance which will be cloned. |
| `database_instances.clone.point_in_time` | String | No | null | The timestamp of the point in time that should be restored. A timestamp in RFC3339 UTC "Zulu" format, with nanosecond resolution and up to nine fractional digits. Examples: "2014-10-02T15:01:23Z" and "2014-10-02T15:01:23.045123456Z". |
| `database_instances.clone.preferred_zone` | String | No | null | (Point-in-time recovery for PostgreSQL only) Clone to an instance in the specified zone. If no zone is specified, clone to the same zone as the source instance. clone-unavailable-instance |
| `database_instances.clone.database_names` | String | No | null | (SQL Server only, use with point_in_time) Clone only the specified databases from the source instance. Clone all databases if empty. |
| `database_instances.clone.allocated_ip_range` | String | No | null | The name of the allocated ip range for the private ip CloudSQL instance. For example: "google-managed-services-default". If set, the cloned instance ip will be created in the allocated range. The range name must comply with RFC 1035. Specifically, the name must be 1-63 characters long and match the regular expression a-z?. |
| `database_instances.restore_backup_context` | List | No | [] | The optional restore_backup_context block supports: NOTE: Restoring from a backup is an imperative action and not recommended via Terraform. Adding or modifying this block during resource creation/update will trigger the restore action after the resource is created/updated. |
| `database_instances.restore_backup_context.backup_run_id` | String | No | null | The ID of the backup run to restore from. |
| `database_instances.restore_backup_context.instance_id` | String | No | null | The ID of the instance that the backup was taken from. If left empty, this instance's ID will be used. |
| `database_instances.restore_backup_context.project` | String | No | null | The full project ID of the source instance. |
| `source_representation_instances.region` | String | Yes | - | The Region in which the created instance should reside. If it is not provided, the provider region is used. |
| `source_representation_instances.project` | String | No | null | The ID of the project in which the resource belongs. If it is not provided, the provider project is used. |
| `source_representation_instances.database_version` | String | Yes | - | The MySQL version running on your source database server. Possible values are: MYSQL_5_6, MYSQL_5_7, MYSQL_8_0, POSTGRES_9_6, POSTGRES_10, POSTGRES_11, POSTGRES_12, POSTGRES_13, POSTGRES_14. |
| `source_representation_instances.host` | String | Yes | - | The IPv4 address and port for the external server, or the the DNS address for the external server. If the external server is hosted on Cloud SQL, the port is 5432. |
| `source_representation_instances.port` | String | No | null | The externally accessible port for the source database server. Defaults to 3306. |
| `source_representation_instances.username` | String | No | null | The replication user account on the external server. |
| `source_representation_instances.password` | String | No | null | The password for the replication user account. Note: This property is sensitive and will not be displayed in the plan. |
| `source_representation_instances.dump_file_path` | String | No | null | A file in the bucket that contains the data from the external server. |
| `source_representation_instances.ca_certificate` | String | No | null | The CA certificate on the external server. Include only if SSL/TLS is used on the external server. |
| `source_representation_instances.client_certificate` | String | No | null | The client certificate on the external server. Required only for server-client authentication. Include only if SSL/TLS is used on the external server. |
| `source_representation_instances.client_key` | String | No | null | The private key file for the client certificate on the external server. Required only for server-client authentication. Include only if SSL/TLS is used on the external server. |
| `ssl_certs.instance` | String | Yes | - | The name of the Cloud SQL instance. Changing this forces a new resource to be created. |
| `ssl_certs.project` | String | No | null | The ID of the project in which the resource belongs. If it is not provided, the provider project is used. |
| `users.instance` | String | Yes | - | The name of the Cloud SQL instance. Changing this forces a new resource to be created. |
| `users.password` | String | No | null | The password for the user. Can be updated. For Postgres instances this is a Required field, unless type is set to either CLOUD_IAM_USER or CLOUD_IAM_SERVICE_ACCOUNT. Don't set this field for CLOUD_IAM_USER and CLOUD_IAM_SERVICE_ACCOUNT user types for any Cloud SQL instance. |
| `users.type` | String | No | null | The user type. It determines the method to authenticate the user during login. The default is the database's built-in user type. Flags include "BUILT_IN", "CLOUD_IAM_USER", "CLOUD_IAM_GROUP" or "CLOUD_IAM_SERVICE_ACCOUNT". |
| `users.host` | String | No | null | The host the user can connect from. This is only supported for BUILT_IN users in MySQL instances. Don't set this field for PostgreSQL and SQL Server instances. Can be an IP address. Changing this forces a new resource to be created. |
| `users.project` | String | No | null | The ID of the project in which the resource belongs. If it is not provided, the provider project is used. |
| `users.password_policy` | List | No | [] | The optional password_policy block is only supported by Mysql. |
| `users.password_policy.allowed_failed_attempts` | Int | No | null | Number of failed attempts allowed before the user get locked. |
| `users.password_policy.password_expiration_duration` | Int | No | null | Password expiration duration with one week grace period. |
| `users.password_policy.enable_failed_attempts_check` | Bool | No | null | If true, the check that will lock user after too many failed login attempts will be enabled. |
| `users.password_policy.enable_password_verification` | Bool | No | null | If true, the user must specify the current password before changing the password. This flag is supported only for MySQL. |

## Example

Usage example located in this [directory](docs/example).
