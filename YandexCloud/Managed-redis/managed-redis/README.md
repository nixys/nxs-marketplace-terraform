# Managed-redis

## Introduction

This is a set of terraform modules for the Yandex Cloud provider for building a Managed-redis and creating any different redis resources

## Features

- Supported redis-cluster
- Supported random password

## Settings

| Option | Type | Required | Default value |Description |
| --- | ---  | --- | --- | --- |
| `clusters.environment` | String | Yes | "PRODUCTION" | Deployment environment of the Redis cluster. Can be either PRESTABLE or PRODUCTION. |
| `clusters.description` | String | No | "Created by Terraform" | Description of the Redis cluster. |
| `clusters.version` | String | No | null | Version of Redis (6.2). |
| `clusters.timeout` | String | No | null | Close the connection after a client is idle for N seconds. |
| `clusters.maxmemory_policy` | String | No | null | Redis key eviction policy for a dataset that reaches maximum memory. |
| `clusters.notify_keyspace_events` | String | No | null | Select the events that Redis will notify among a set of classes. |
| `clusters.slowlog_log_slower_than` | Int | No | null | Log slow queries below this number in microseconds. |
| `clusters.slowlog_max_len` | Int | No | null | Slow queries log length. |
| `clusters.databases` | String | No | null | Number of databases (changing requires redis-server restart). |
| `clusters.maxmemory_percent` | Int | No | null | Redis maxmemory usage in percent. |
| `clusters.client_output_buffer_limit_normal` | String | No | null | Normal clients output buffer limits. |
| `clusters.client_output_buffer_limit_pubsub` | String | No | null | Pubsub clients output buffer limits. |
| `clusters.disk_size` | Int | Yes | 16 | Volume of the storage available to a host, in gigabytes. |
| `clusters.disk_type` | String | No | "network-ssd" | Type of the storage of Redis hosts - environment default is used if missing. |
| `clusters.instance_type` | String | No | "b3-c1-m4" | The ID of the preset for computational resources available to a host (CPU, memory etc.). |
| `clusters.redis_hosts` | List | No | [] | A host of the Redis cluster. |
| `clusters.redis_hosts.zone` | String | Yes | - | The availability zone where the Redis host will be created. |
| `clusters.redis_hosts.assign_public_ip` | Bool | No | null | Sets whether the host should get a public IP address or not. |
| `clusters.redis_hosts.subnet_id` | String | No | null | The ID of the subnet, to which the host belongs. The subnet must be a part of the network to which the cluster belongs. |
| `clusters.redis_hosts.replica_priority` | Int | No | null | Replica priority of a current replica (usable for non-sharded only). |
| `clusters.redis_hosts.shard_name` | String | No | null | The name of the shard to which the host belongs. |
| `clusters.sharded` | Bool | No | null | Redis Cluster mode enabled/disabled. Enables sharding when cluster non-sharded. If cluster is sharded - disabling is not allowed. |
| `clusters.tls_enabled` | Bool | No | null | TLS support mode enabled/disabled. |
| `clusters.persistence_mode` | Bool | No | null | Persistence mode. |
| `clusters.security_group_ids` | List | No | [] | A set of ids of security groups assigned to hosts of the cluster. |
| `clusters.deletion_protection` | Bool | No | null | Inhibits deletion of the cluster. Can be either true or false. |
| `clusters.maintenance_window_type` | String | Yes | "WEEKLY" | Type of maintenance window. Can be either ANYTIME or WEEKLY. A day and hour of window need to be specified with weekly window. |
| `clusters.maintenance_window_day` | String | No | "WEN" | Day of week for maintenance window if window type is weekly. Possible values: MON, TUE, WED, THU, FRI, SAT, SUN. |
| `clusters.maintenance_window_hour` | Int | No | 23 | Hour of day in UTC time zone (1-24) for maintenance window if window type is weekly. |
| `clusters.labels` | Map | No | {} | A set of key/value label pairs to assign to the Redis cluster. |

## Example

Usage example located in this [directory](docs/example).
