# Database

## Introduction

This is a set of terraform modules for the SberCloud provider for building a database and creating any different database resources

## Modules

| Modules | Settings | Resources | Description |
| --- | ---  | --- | --- |
| `rds` |[rds](rds/README.md)| - sbercloud_rds_instance<br> - sbercloud_rds_parametergroup<br> - sbercloud_rds_backup<br> - sbercloud_rds_read_replica_instance | RDS settings |
| `dds` |[dds](dds/README.md)| - sbercloud_dds_instance | DDS settings |
