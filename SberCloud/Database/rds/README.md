# Relational Database Service (RDS)

## Introduction

This is a set of terraform modules for the SberCloud provider for building a Database and creating Relation Database Service resources.

## Features

- Supported RDS
- Supported parametr groups
- Supported Database instance
- Supported backups

## Settings

| Option | Type | Required | Default value | Description |
| --- | --- | --- | --- | --- |
| `general_project_id` | String | No | `null` | Default project |
| `general_region` | String | No | `null` | Default region |
| `instance.project_id` | String | Yes | var.general_project_id | The enterprise project id of the RDS instance. Changing this parameter creates a new RDS instance. |
| `instance.region` | String | No | var.general_region | The region in which to create the rds instance resource. If omitted, the provider-level region will be used. Changing this creates a new rds instance resource. |
| `instance.vpc_id` | String | Yes | null | Specifies the VPC ID. Changing this parameter will create a new resource. |
| `instance.subnet_id` | String | Yes | null | Specifies the network id of a subnet. Changing this parameter will create a new resource. |
| `instance.security_group_id` | String | Yes | null | Specifies the security group which the RDS DB instance belongs to. Changing this parameter will create a new resource. |
| `instance.availability_zone` | List | Yes | ["ru-moscow-1a"] | Specifies the list of AZ name. Changing this parameter will create a new resource. |
| `instance.database_type` | String | Yes | null | Specifies the DB engine. Available value are MySQL, PostgreSQL and SQLServer. Changing this parameter will create a new resource. |
| `instance.database_version` | String | Yes | null | Specifies the database version. Changing this parameter will create a new resource. |
| `instance.cpu` | Int | Yes | null | Database instance CPU settings. Changing this parameter will create a new resource. |
| `instance.memory` | Int | Yes | null | Database instance Memory settings. Changing this parameter will create a new resource. |
| `instance.group_type` | String | Yes | null | Database instance Flavor settings. Changing this parameter will create a new resource. |
| `instance.database_password` | String | Yes | "wdWt0MeKH4g08tJMrLksJpgUKCBv!12" | Specifies the database password. The value cannot be empty and should contain 8 to 32 characters, including uppercase and lowercase letters, digits, and the following special characters: ~!@#%^*-_=+? You are advised to enter a strong password to improve security, preventing security risks such as brute force cracking. Changing this parameter will create a new resource. |
| `instance.database_template` | String | No | null | Specifies the parameter name. Changing this parameter will create a new resource. |
| `instance.port` | Int | No | null | Specifies the database port. Changing this parameter will create a new resource. |
| `instance.ha_replication_mode` | String | No | null | Specifies the replication mode for the standby DB instance. Changing this parameter will create a new resource. |
| `instance.time_zone` | String | No | "UTC+03:00" | Specifies the UTC time zone. The value ranges from UTC-12:00 to UTC+12:00 at the full hour. |
| `instance.fixed_ip` | String | No | null | Specifies an intranet floating IP address of RDS DB instance. Changing this parameter will create a new resource. |
| `instance.volume_type` | String | Yes | "ULTRAHIGH" | Specifies the volume type. |
| `instance.volume_size` | Int | Yes | 40 | Specifies the volume size. Its value range is from 40 GB to 4000 GB. The value must be a multiple of 10 and greater than the original size. |
| `instance.volume_disk_encryption_id` | String | No | null | Specifies the key ID for disk encryption. Changing this parameter will create a new resource. |
| `instance.backup_start_time` | String | Yes | "08:00-09:00" | Specifies the backup time window. Automated backups will be triggered during the backup time window. It must be a valid value in the hh:mm-HH:MM format. The current time is in the UTC format. The HH value must be 1 greater than the hh value. The values of mm and MM must be the same and must be set to any of the following: 00, 15, 30, or 45. Example value: 08:15-09:15 23:00-00:00. |
| `instance.backup_keep_days` | Int | No | 1 | Specifies the retention days for specific backup files. The value range is from 0 to 732. If this parameter is not specified or set to 0, the automated backup policy is disabled. |
| `instance.parameters` | List | No | [] | Specify an array of one or more parameters to be set to the RDS instance after launched. |
| `instance.tags` | Map | No | {} | A mapping of tags to assign to the RDS instance. Each tag is represented by one key-value pair. |
| `custom_database_template.region` | String | No | var.general_region | The region in which to create the RDS parameter group. If omitted, the provider-level region will be used. Changing this creates a new parameter group. |
| `custom_database_template.description` | String | No | "Created by Terraform" | The parameter group description. It contains a maximum of 256 characters and cannot contain the following special characters:>!<"&'= the value is left blank by default. |
| `custom_database_template.database_type` | String | Yes | null | The DB engine. Currently, MySQL, PostgreSQL, and Microsoft SQL Server are supported. |
| `custom_database_template.database_version` | String | Yes | null | Specifies the database version. |
| `custom_database_template.values` | Map | No | {} | Parameter group values key/value pairs defined by users based on the default parameter groups. |
| `custom_database_backup.region` | String | No | var.general_region | Specifies the region in which to create the resource. If omitted, the provider-level region will be used. Changing this parameter will create a new resource. |
| `custom_database_backup.description` | String | No | "Created by Terraform" | The description about the backup. It contains a maximum of 256 characters and cannot contain the following special characters: >!<"&'=. Changing this parameter will create a new resource. |
| `custom_database_backup.instance_rds_name` | String | Yes | null | Instance name for attach. Changing this parameter will create a new resource. |
| `custom_database_backup.database_name` | List | No | [] | List of self-built Microsoft SQL Server databases that are partially backed up. |
| `custom_replicas.enterprise_project_id` | String | Yes | var.general_project_id | Specifies a unique id in UUID format of enterprise project. |
| `custom_replicas.region` | String | No | var.general_region | The region in which to create the rds read replica instance resource. If omitted, the provider-level region will be used. |
| `custom_replicas.database_type` | String | Yes | null | Specifies the DB engine. Available value are MySQL, PostgreSQL and SQLServer. Changing this parameter will create a new resource. |
| `custom_replicas.database_version` | String | Yes | null | Specifies the database version. Changing this parameter will create a new resource. |
| `custom_replicas.cpu` | Int | Yes | null | Database instance CPU settings. Changing this parameter will create a new resource. |
| `custom_replicas.memory` | Int | Yes | null | Database instance Memory settings. Changing this parameter will create a new resource. |
| `custom_replicas.group_type` | String | Yes | null | Database instance Flavor settings. Changing this parameter will create a new resource. |
| `custom_replicas.primary_instance_name` | String | Yes | null | pecifies the DB instance Name, which is used to create a read replica. |
| `custom_replicas.availability_zone` | String | Yes | "ru-moscow-1a" | Specifies the AZ name. Changing this parameter will create a new resource. |
| `custom_replicas.volume_type` | String | Yes | "ULTRAHIGH" | Specifies the volume type. |
| `custom_replicas.volume_disk_encryption_id` | String | No | null | Specifies the key ID for disk encryption. Changing this parameter will create a new resource. |
| `custom_replicas.tags` | String | No | {} | A mapping of tags to assign to the RDS read replica instance. Each tag is represented by one key-value pair.  |

## Example

Usage example located in this [directory](docs/example).
