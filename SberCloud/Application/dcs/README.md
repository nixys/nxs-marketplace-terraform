# Database Cache Service (DCS)

## Introduction

This is a set of terraform modules for the SberCloud provider for building a Database Cache Service and creating DCS resources.

## Features

- Supported DCS
- Supported DCS parametrs
- Supported DCS restore
- Supported random password

## Settings

| Option | Type | Required | Default value | Description |
| --- | --- | --- | --- | --- |
| `general_project_id` | String | No | `null` | Default project |
| `general_region` | String | No | `null` | Default region |
| `instances.project_id` | String | No | general_project_id | The enterprise project id of the dcs instance. Changing this creates a new instance. |
| `instances.region`             | String | No | general_region |  | 
| `instances.capacity`           | Int | No | null | Specifies the cache capacity. Unit: GB. | 
| `instances.cache_mode`         | String | No | null | The mode of a cache engine. | 
| `instances.cpu_architecture`   | String | Yes | - | The CPU architecture of cache instance. Valid values x86_64 and aarch64. |
| `instances.description`        | String | No | null | Specifies the description of an instance. It is a string that contains a maximum of 1024 characters. | 
| `instances.engine`             | String | Yes | - | Specifies a cache engine. Options: Redis and Memcached. Changing this creates a new instance. |
| `instances.engine_version`     | String | Yes | - | Specifies the version of a cache engine. It is mandatory when the engine is Redis, the value can be 3.0, 4.0, 5.0 or 6.0. Changing this creates a new instance. |
| `instances.availability_zones` | List | Yes | - | The code of the AZ where the cache node resides. Master/Standby, Proxy Cluster, and Redis Cluster DCS instances support cross-AZ deployment. You can specify an AZ for the standby node. When specifying AZs for nodes, use commas (,) to separate AZs. Changing this creates a new instance. | 
| `instances.vpc_id`             | String | Yes | - | The ID of VPC which the instance belongs to. Changing this creates a new instance resource. |
| `instances.subnet_id`          | String | Yes | - | The ID of subnet which the instance belongs to. Changing this creates a new instance resource. |
| `instances.security_group_id`  | List | No | [] | The ID of the security group which the instance belongs to. This parameter is mandatory for Memcached and Redis 3.0 version. | 
| `instances.private_ip`         | String | No | null | The IP address of the DCS instance, which can only be the currently available IP address the selected subnet. You can specify an available IP for the Redis instance (except for the Redis Cluster type). If omitted, the system will automatically allocate an available IP address to the Redis instance. Changing this creates a new instance resource. | 
| `instances.port`               | Int | No | 6379 | Port customization, which is supported only by Redis 4.0 and Redis 5.0 instances. Redis instance defaults to 6379. Memcached instance does not use this argument. | 
| `instances.whitelist_enable`   | Bool | No | null | Enable or disable the IP address whitelists. Defaults to true. If the whitelist is disabled, all IP addresses connected to the VPC can access the instance. | 
| `instances.maintain_begin`     | String | No | null | Time at which the maintenance time window starts. The valid values are 22:00:00, 02:00:00, 06:00:00, 10:00:00, 14:00:00 and 18:00:00. Default value is 02:00:00. | 
| `instances.maintain_end`       | String | No | null | Time at which the maintenance time window ends. The valid values are 22:00:00, 02:00:00, 06:00:00, 10:00:00, 14:00:00 and 18:00:00. Default value is 06:00:00. | 
| `instances.rename_commands`    | String | No | null | Critical command renaming, which is supported only by Redis 4.0 and Redis 5.0 instances but not by Redis 3.0 instance. The valid commands that can be renamed are: command, keys, flushdb, flushall and hgetall. | 
| `instances.charging_mode`      | String | No | null | Specifies the charging mode of the redis instance. | 
| `instances.period_unit`        | String | No | null | Specifies the charging period unit of the instance. Valid values are month and year. This parameter is mandatory if charging_mode is set to prePaid. Changing this creates a new instance. | 
| `instances.period`             | String | No | null | Specifies the charging period of the instance. If period_unit is set to month, the value ranges from 1 to 9. If period_unit is set to year, the value ranges from 1 to 3. This parameter is mandatory if charging_mode is set to prePaid. Changing this creates a new instance. | 
| `instances.auto_renew`         | Bool | No | null | Specifies whether auto renew is enabled. Valid values are true and false, defaults to false. | 
| `instances.access_user`        | String | No | null | Specifies the username used for accessing a DCS Memcached instance. If the cache engine is Redis, you do not need to set this parameter. The username starts with a letter, consists of 1 to 64 characters, and supports only letters, digits, and hyphens (-). Changing this creates a new instance. | 
| `instances.tags`               | Map | No | {} | The key/value pairs to associate with the dcs instance. | 
| `instances.whitelists`         | List | No | [] | Specifies the IP addresses which can access the instance. This parameter is valid for Redis 4.0 and 5.0 versions | 
| `instances.whitelists.group_name` | String | Yes | - | Specifies the name of IP address group. | 
| `instances.whitelists.ip_address` | String | Yes | - | Specifies the list of IP address or CIDR which can be whitelisted for an instance. The maximum is 20. | 
| `instances.backup_policy`         | List | No | [] | Specifies the backup configuration to be used with the instance. | 
| `instances.backup_policy.backup_type` | String | No | null | Backup type. Default value is auto. | 
| `instances.backup_policy.save_days` | Int | No | null | Retention time. Unit: day, the value ranges from 1 to 7. This parameter is required if the backup_type is auto. | 
| `instances.backup_policy.period_type` | String | No | null | Interval at which backup is performed. Default value is weekly. Currently, only weekly backup is supported. | 
| `instances.backup_policy.backup_at` | List | Yes | - | Day in a week on which backup starts, the value ranges from 1 to 7. Where: 1 indicates Monday; 7 indicates Sunday. | 
| `instances.backup_policy.begin_at` | String | Yes | - | Time at which backup starts. Format: hh24:00-hh24:00, "00:00-01:00" indicates that backup starts at 00:00:00. | 
| `instances.parameters_timeout` | String | No | null | Close the connection after a client is idle for N seconds (0 to disable). Value range: 0-7200. Default value: 0. Works on Redis & Memcached. |
| `instances.parameters_maxmemory-policy` | String | No | null | How Redis will select what to remove when maxmemory is reached, You can select among five behaviors: volatile-lru : remove the key with an expire set using an LRU algorithm; allkeys-lru: remove any key according to the LRU algorithm; volatile-lfu:remove the key with an expire set using an LFU algorithm; allkeys-lfu:remove any key according to the LFU algorithm; volatile-random: remove a random key with an expire set; allkeys-random: remove a random key, any key; volatile-ttl: remove the key with the nearest expire time (minor TTL); noeviction: don't expire at all, just return an error on write operations. Default value: volatile-lru. Works on Redis & Memcached. |
| `instances.parameters_hash-max-ziplist-entries` | String | No | null | Hashes are encoded using a memory efficient data structure when they have a small number of entries. Value range: 1-10000. Default value: 512. Works only on Redis. |
| `instances.parameters_hash-max-ziplist-value` | String | No | null | Hashes are encoded using a memory efficient data structure when the biggest entry does not exceed a given threshold. Value range: 1-10000. Default value: 64. Works only on Redis. |
| `instances.parameters_set-max-Stringset-entries` | String | No | null | When a set is composed of just strings that happen to be integers in radix 10 in the range of 64 bit signed integers. Value range: 1-10000. Default value: 512. Works only on Redis. |
| `instances.parameters_zset-max-ziplist-entries` | String | No | null | Sorted sets are encoded using a memory efficient data structure when they have a small number of entries. Value range: 1-10000. Default value: 128. Works only on Redis. |
| `instances.parameters_zset-max-ziplist-value` | String | No | null | Sorted sets are encoded using a memory efficient data structure when the biggest entry does not exceed a given threshold. Value range: 1-10000. Default value: 64. Works only on Redis. |
| `instances.parameters_latency-monitor-threshold` | String | No | null | Only events that run in more time than the configured latency-monitor-threshold will be logged as latency spikes. If latency-monitor-threshold is set to 0, latency monitoring is disabled. If latency-monitor-threshold is set to a value greater than 0, all events blocking the server for a time equal to or greater than the configured latency-monitor-threshold will be logged. Value range: 0-86400000. Default value: 0. Works only on Redis. |
| `instances.parameters_maxclients` | String | No | null | Set the max number of connected clients at the same time. Value range: 1000-50000. Default value: 10000. Works on Redis & Memcached. |
| `instances.parameters_notify-keyspace-events` | String | No | null | Redis can notify Pub or Sub clients about events happening in the key space. Default value: "Ex". Works only on Redis. |
| `instances.parameters_repl-backlog-size` | String | No | null | The replication backlog size in bytes for PSYNC. This is the size of the buffer which accumulates slave data when slave is disconnected for some time, so that when slave reconnects again, only transfer the portion of data which the slave missed. Value range: 16384-1073741824. Default value: 1048576. Works only on Redis. |
| `instances.parameters_repl-backlog-ttl` | String | No | null | The amount of time in seconds after the master no longer have any slaves connected for the master to free the replication backlog. A value of 0 means to never release the backlog. Value range: 0-604800. Default value: 3600. Works only on Redis. |
| `instances.parameters_appendfsync` | String | No | null | The fsync() call tells the Operating System to actually write data on disk instead of waiting for more data in the output buffer. Some OS will really flush data on disk, some other OS will just try to do it ASAP. Redis supports three different modes: 1) no: don't fsync, just let the OS flush the data when it wants. 2) Faster. always: fsync after every write to the append only log. 3) Slow, Safest. everysec: fsync only one time every second. Compromise. Value range: "no,always,everysec". Default value: "no". Works only on Redis. |
| `instances.parameters_appendonly` | String | No | null | Configuration item for AOF persistence. Value range: "no, yes". Default value: "yes". Works only on Redis. |
| `instances.parameters_slowlog-log-slower-than` | String | No | null | The Redis Slow Log is a system to log queries that exceeded a specified execution time. Slowlog-log-slower-than tells Redis what is the execution time, in microseconds, to exceed in order for the command to get logged. Value range: 0-1000000. Default value: 10000. Works only on Redis. |
| `instances.parameters_slowlog-max-len` | String | No | null | The Redis Slow Log is a system to log queries that exceeded a specified execution time. Slowlog-log-slower-than tells Redis what is the execution time, in microseconds, to exceed in order for the command to get logged. Value range: 0-1000. Default value: 128. Works only on Redis. |
| `instances.parameters_lua-time-limit` | String | No | null | Max execution time of a Lua script in milliseconds. Value range: 100-5000. Default value: 5000. Works only on Redis. |
| `instances.parameters_repl-timeout` | String | No | null | Replication timeout in seconds. Value range: 30-3600. Default value: 60. Works only on Redis. |
| `instances.parameters_proto-max-bulk-len` | String | No | null | Max bulk request size in bytes. Value range: 1048576-536870912. Default value: 536870912. Works only on Redis. |
| `instances.parameters_master-read-only` | String | No | null | Set redis to read only state and all write commands will fail. Value range: "yes,no". Default value: "no". Works only on Redis. |
| `instances.parameters_client-output-buffer-slave-soft-limit` | String | No | null | Set redis to read only state and all write commands will fail. Value range: 0-1073741824. Default value: 107374182. Works only on Redis. |
| `instances.parameters_client-output-buffer-slave-hard-limit` | String | No | null | Set redis to read only state and all write commands will fail. Value range: 0-1073741824. Default value: 107374182. Works only on Redis. |
| `instances.parameters_client-output-buffer-limit-slave-soft-seconds` | String | No | null | Set redis to read only state and all write commands will fail. Value range: 0-60. Default value: 60. Works only on Redis. |
| `instances.parameters_active-expire-num` | String | No | null | How many keys can be freed by expire cycle. Value range: 1-1000. Default value: 20. Works only on Redis. |
| `instances.parameters_reserved-memory-percent` | String | No | null | The percent of memory reserved for non-cache memory usage. You may want to increase this parameter for nodes with read replicas, AOF enabled, etc, to reduce swap usage. Value range: 0-80. Default value: 0. Works only on Memcached. |
| `backups.region`        | String | No | null | Specifies the region in which to create the resource. If omitted, the provider-level region will be used. Changing this parameter will create a new resource. |
| `backups.instance_name`   | String | Yes | - | Specifies the ID of the DCS instance. |
| `backups.description`   | String | No | null | Specifies the description of DCS instance backup. |
| `backups.backup_format` | String | No | null | Specifies the format of the DCS instance backup. Value options: aof, rdb. Default to rdb. |
| `restores.project_id`  | String | Yes | - | The enterprise project id of the dcs instance. Changing this creates a new instance. |
| `restores.instance_name` | String | Yes | - | A dcs_instance ID in UUID format. |
| `restores.backup_name`   | String | Yes | - | ID of the backup record. |
| `restores.remark`      | String | No  | null | Description of DCS instance restoration. |

## Example

Usage example located in this [directory](docs/example).
