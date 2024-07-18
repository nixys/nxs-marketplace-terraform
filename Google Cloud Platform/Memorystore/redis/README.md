# Redis

## Introduction

This is a set of terraform modules for the Google Cloud Platform provider for building a Memorystore and creating any different redis resources

## Features

- Supported redis instances
- Supported redis clusters

## Settings

| Option | Type | Required | Default value | Description |
| --- | ---  | --- | --- | --- |
| `redis.is_cluster` | Bool | Yes | - | Determines which resource will be used. Possible values are: `false` for `google_redis_instance`, `true` for `google_redis_cluster`. |
| `redis.replica_count` | Int | No | 0 or 1 | The number of replica nodes. The valid range for the Standard Tier with read replicas enabled is `[1-5]` and defaults to `2`. If read replicas are not enabled for a Standard Tier instance, the only valid value is `1` and the default is `1`. The valid value for basic tier is `0` and the default is also `0`. |
| `redis.redis_configs` | Map | No | {} | Redis configuration parameters, according to [official documentation](http://redis.io/topics/config). Please check [Memorystore documentation](https://cloud.google.com/memorystore/docs/redis/reference/rest/v1/projects.locations.instances#Instance.FIELDS.redis_configs) for the list of supported parameter.  |
| `redis.region` | String | No | null | The name of the Redis region of the instance. |
| `redis.project` | String | No | null | The ID of the project in which the resource belongs. If it is not provided, the provider project is used. |
| `redis.memory_size_gb` | Int | Yes | - | Redis memory size in GiB. Used only if `redis.is_cluster` is `false`. |
| `redis.alternative_location_id` | String | No | null | Only applicable to `STANDARD_HA` tier which protects the instance against zonal failures by provisioning it across two zones. If provided, it must be a different zone from the one provided in `redis.alternative_location_id`. Used only if `redis.is_cluster` is `false`. |
| `redis.auth_enabled` | Bool | No | false | Indicates whether OSS Redis AUTH is enabled for the instance. If set to `true` AUTH is enabled on the instance. Default value is `false` meaning AUTH is disabled. Used only if `redis.is_cluster` is `false`. |
| `redis.authorized_network` | String | No | null | The full name of the Google Compute Engine network to which the instance is connected. If left unspecified, the default network will be used. Used only if `redis.is_cluster` is `false`. |
| `redis.connect_mode` | String | No | DIRECT_PEERING | The connection mode of the Redis instance. Default value is `DIRECT_PEERING`. Possible values are: `DIRECT_PEERING`, `PRIVATE_SERVICE_ACCESS`. Used only if `redis.is_cluster` is `false`. |
| `redis.display_name` | String | No | null | An arbitrary and optional user-provided name for the instance. Used only if `redis.is_cluster` is `false`. Used only if `redis.is_cluster` is `false`. |
| `redis.labels` | Map | No | {} | Resource labels to represent user provided metadata. **Note:** This field is non-authoritative, and will only manage the labels present in your configuration. Please refer to the field `effective_labels` for all of the labels present on the resource. Used only if `redis.is_cluster` is `false`. Used only if `redis.is_cluster` is `false`. |
| `redis.location_id` | String | No | null | The zone where the instance will be provisioned. If not provided, the service will choose a zone for the instance. For `STANDARD_HA` tier, instances will be created across two zones for protection against zonal failures. If `redis.alternative_location_id` is also provided, it must be different from `redis.location_id`. Used only if `redis.is_cluster` is `false`. Used only if `redis.is_cluster` is `false`. |
| `redis.persistence_config` | List | No | [] | Persistence configuration for an instance. Used only if `redis.is_cluster` is `false`. |
| `redis.persistence_config.persistence_mode` | String | Yes | - | Controls whether Persistence features are enabled. If not provided, the existing value will be used. `DISABLED`: Persistence is disabled for the instance, and any existing snapshots are deleted. `RDB`: RDB based Persistence is enabled. Possible values are: `DISABLED`, `RDB`. |
| `redis.persistence_config.rdb_snapshot_period` | String | No | null | Available snapshot periods for scheduling. Possible values are: `ONE_HOUR`, `SIX_HOURS`, `TWELVE_HOURS`, `TWENTY_FOUR_HOURS`. |
| `redis.persistence_config.rdb_snapshot_start_time` | String | No | null | Date and time that the first snapshot was/will be attempted, and to which future snapshots will be aligned. If not provided, the current time will be used. A timestamp in **RFC3339** **UTC** "Zulu" format, with nanosecond resolution and up to nine fractional digits. Examples: `2024-10-02T15:01:23Z` and `2024-10-02T15:01:23.045123456Z`. |
| `redis.maintenance_policy` | List | No | [] | Maintenance policy for an instance. Used only if `redis.is_cluster` is `false`. |
| `redis.maintenance_policy.description` | String | No | null | Description of what this policy is for. Create/Update methods return **INVALID_ARGUMENT** if the length is greater than 512. |
| `redis.maintenance_policy.weekly_maintenance_window` | List | No | [] | Maintenance window that is applied to resources covered by this policy. **Minimum 1**. For the current version, the maximum number of `weekly_window` is expected to be one. Used only if `redis.is_cluster` is `false`. |
| `redis.maintenance_policy.weekly_maintenance_window.day` | String | Yes | - | The day of week that maintenance updates occur. Possible values are: `DAY_OF_WEEK_UNSPECIFIED`, `MONDAY`, `TUESDAY`, `WEDNESDAY`, `THURSDAY`, `FRIDAY`, `SATURDAY`, `SUNDAY`. |
| `redis.maintenance_policy.weekly_maintenance_window.start_time` | List | Yes | - | Start time of the window in UTC time. |
| `redis.maintenance_policy.weekly_maintenance_window.hours` | String | No | null | Hours of day in 24 hour format. Should be from `0 to 23`. An API may choose to allow the value `24:00:00` for scenarios like business closing time. |
| `redis.maintenance_policy.weekly_maintenance_window.minutes` | String | No | null | Minutes of hour of day. Must be from `0 to 59`. |
| `redis.maintenance_policy.weekly_maintenance_window.seconds` | String | No | null | Seconds of minutes of the time. Must normally be from `0 to 59`. An API may allow the value `60` if it allows leap-seconds. |
| `redis.maintenance_policy.weekly_maintenance_window.nanos` | String | No | null | Fractions of seconds in nanoseconds. Must be from `0 to 999,999,999`. |
| `redis.redis_version` | String | No | null | The version of Redis software. If not provided, latest supported version will be used. Please check the [API documentation](https://cloud.google.com/memorystore/docs/redis/reference/rest/v1/projects.locations.instances) for the latest valid values. Possible values are: `REDIS_3_2`, `REDIS_4_0`, `REDIS_5_0`, `REDIS_6_X`, `REDIS_7_0`. Used only if `redis.is_cluster` is `false`. |
| `redis.reserved_ip_range` | String | No | null | The CIDR range of internal addresses that are reserved for this instance. If not provided, the service will choose an unused **/29** block, for example, `10.0.0.0/29` or `192.168.0.0/29`. Ranges must be unique and non-overlapping with existing subnets in an authorized network. Used only if `redis.is_cluster` is `false`. |
| `redis.tier` | String | No | BASIC | The service tier of the instance. Must be one of these values: `BASIC`: standalone instance. `STANDARD_HA`: highly available primary/replica instances. Default value is `BASIC`. Possible values are: `BASIC`, `STANDARD_HA`. Used only if `redis.is_cluster` is `false`. |
| `redis.transit_encryption_mode` | String | No | DISABLED | The TLS mode of the Redis instance, If not provided, TLS is disabled for the instance. `SERVER_AUTHENTICATION`: Client to Server traffic encryption enabled with server authentication. Default value is `DISABLED`. Possible values are: `SERVER_AUTHENTICATION`, `DISABLED`. Used only if `redis.is_cluster` is `false`. |
| `redis.read_replicas_mode` | String | No | READ_REPLICAS_DISABLED | Read replica mode. Can only be specified when trying to create the instance. If not set, Memorystore Redis backend will default to `READ_REPLICAS_DISABLED`. `READ_REPLICAS_DISABLED`: If disabled, read endpoint will not be provided and the instance cannot scale up or down the number of replicas. `READ_REPLICAS_ENABLED`: If enabled, read endpoint will be provided and the instance can scale up and down the number of replicas. Possible values are: `READ_REPLICAS_DISABLED`, `READ_REPLICAS_ENABLED`. Used only if `redis.is_cluster` is `false`. |
| `redis.secondary_ip_range` | String | No | null | Additional IP range for node placement. Required when enabling read replicas on an existing instance. For `redis.connect_mode = DIRECT_PEERING` mode value must be a CIDR range of size **/28**, or "auto". For `redis.connect_mode = PRIVATE_SERVICE_ACCESS` mode value must be the name of an allocated address range associated with the private service access connection, or "auto". Used only if `redis.is_cluster` is `false`. |
| `redis.customer_managed_key` | String | No | null | The KMS key reference that you want to use to encrypt the data at rest for this Redis instance. If this is provided, CMEK is enabled. Used only if `redis.is_cluster` is `false`. |
| `redis.shard_count` | Int | Yes | - | Number of shards for the Redis cluster. Used only if `redis.is_cluster` is `true`. |
| `redis.psc_configs` | List | Yes | - | Each PscConfig configures the consumer network where two network addresses will be designated to the cluster for client access. Currently, only one PscConfig is supported. Used only if `redis.is_cluster` is `true`. |
| `redis.psc_configs.network` | String | Yes | - | The consumer network where the network address of the discovery endpoint will be reserved. Used only if `redis.is_cluster` is `true`. |
| `redis.authorization_mode` | String | No | AUTH_MODE_DISABLED | The authorization mode of the Redis cluster. If not provided, auth feature is disabled for the cluster. Default value is `AUTH_MODE_DISABLED`. Possible values are: `AUTH_MODE_UNSPECIFIED`, `AUTH_MODE_IAM_AUTH`, `AUTH_MODE_DISABLED`. Used only if `redis.is_cluster` is `true`. |
| `redis.transit_encryption_mode` | String | No | TRANSIT_ENCRYPTION_MODE_DISABLED | The in-transit encryption for the Redis cluster. If not provided, encryption is disabled for the cluster. Default value is `TRANSIT_ENCRYPTION_MODE_DISABLED`. Possible values are: `TRANSIT_ENCRYPTION_MODE_UNSPECIFIED`, `TRANSIT_ENCRYPTION_MODE_DISABLED`, `TRANSIT_ENCRYPTION_MODE_SERVER_AUTHENTICATION`. Used only if `redis.is_cluster` is `true`. |
| `redis.node_type` | String | No | REDIS_HIGHMEM_MEDIUM | The nodeType for the Redis cluster. If not provided, `REDIS_HIGHMEM_MEDIUM` will be used as default Possible values are: `REDIS_SHARED_CORE_NANO`, `REDIS_HIGHMEM_MEDIUM`, `REDIS_HIGHMEM_XLARGE`, `REDIS_STANDARD_SMALL`. Used only if `redis.is_cluster` is `true`. |

## Example

Usage example located in this [directory](docs/example).
