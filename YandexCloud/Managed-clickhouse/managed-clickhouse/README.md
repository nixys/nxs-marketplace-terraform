# Managed-clickhouse

## Introduction

This is a set of terraform modules for the Yandex Cloud provider for building a Managed-clickhouse and creating any different clickhouse resources

## Features

- Supported clickhouse-cluster

## Settings

| Option | Type | Required | Default value |Description |
| --- | ---  | --- | --- | --- |
| `clusters.network_id` | String | Yes | - | ID of the network, to which the Clickhouse cluster belongs. |
| `clusters.description` | String | No | "Created by Terraform" | Description of the Clickhouse cluster. |
| `clusters.environment` | String | Yes | "PRODUCTION" | Deployment environment of the Clickhouse cluster. |
| `clusters.version` | Int | No | null | Version of the ClickHouse server software. |
| `clusters.deletion_protection` | Bool | No | false | Inhibits deletion of the cluster. Can be either true or false. |
| `clusters.resources_preset_id` | String | Yes | - | The ID of the preset for computational resources available to a host (CPU, memory etc.).  |
| `clusters.disk_size` | String | Yes | "network-hdd" | Volume of the storage available to a host, in gigabytes. |
| `clusters.disk_type_id` | Int | Yes | 10 | Type of the storage of hosts. |
| `clusters.config_log_level` | String | No | "TRACE" | Clickhouse settings. |
| `clusters.config_max_connections` | Int | No | 100 | Clickhouse settings. |
| `clusters.config_max_concurrent_queries` | Int | No | 50 | Clickhouse settings. |
| `clusters.config_keep_alive_timeout` | Int | No | 3000 | Clickhouse settings. |
| `clusters.config_uncompressed_cache_size` | Int | No | 8589934592 | Clickhouse settings. |
| `clusters.config_mark_cache_size` | Int | No | 5368709120 | Clickhouse settings. |
| `clusters.config_max_table_size_to_drop` | Int | No | 53687091200 | Clickhouse settings. |
| `clusters.config_max_partition_size_to_drop` | Int | No | 53687091200 | Clickhouse settings. |
| `clusters.config_timezone` | String | No | "UTC" | Clickhouse settings. |
| `clusters.config_geobase_uri` | String | No | null | Clickhouse settings. |
| `clusters.config_query_log_retention_size` | Int | No | 1073741824 | Clickhouse settings. |
| `clusters.config_query_log_retention_time` | Int | No | 259200000 | Clickhouse settings. |
| `clusters.config_query_thread_log_enabled` | String | No | true | Clickhouse settings. |
| `clusters.config_query_thread_log_retention_size` | Int | No | 536870912 | Clickhouse settings. |
| `clusters.config_query_thread_log_retention_time` | Int | No | 259200000 | Clickhouse settings. |
| `clusters.config_part_log_retention_size` | Int | No | 536870912 | Clickhouse settings. |
| `clusters.config_part_log_retention_time` | Int | No | 259200000 | Clickhouse settings. |
| `clusters.config_metric_log_enabled` | Bool | No | true | Clickhouse settings. |
| `clusters.config_metric_log_retention_size` | Int | No | 536870912 | Clickhouse settings. |
| `clusters.config_metric_log_retention_time` | Int | No | 259200000 | Clickhouse settings. |
| `clusters.config_trace_log_enabled` | Bool | No | true | Clickhouse settings. |
| `clusters.config_trace_log_retention_size` | Int | No | 536870912 | Clickhouse settings. |
| `clusters.config_trace_log_retention_time` | Int | No | 259200000 | Clickhouse settings. |
| `clusters.config_text_log_enabled` | Bool | No | true | Clickhouse settings. |
| `clusters.config_text_log_retention_size` | Int | No | 536870912 | Clickhouse settings. |
| `clusters.config_text_log_retention_time` | Int | No | 259200000 | Clickhouse settings. |
| `clusters.config_text_log_level` | String | No | "TRACE" | Clickhouse settings. |
| `clusters.config_background_pool_size` | Int | No | 16 | Clickhouse settings. |
| `clusters.config_background_schedule_pool_size` | Int | No | 16 | Clickhouse settings. |
| `clusters.merge_tree` | List | No | [] | MergeTree engine configuration. |
| `clusters.merge_tree.replicated_deduplication_window` | Int | No | null | Replicated deduplication window: Number of recent hash blocks that ZooKeeper will store (the old ones will be deleted). |
| `clusters.merge_tree.replicated_deduplication_window_seconds` | Int | No | null | Replicated deduplication window seconds: Time during which ZooKeeper stores the hash blocks (the old ones wil be deleted). |
| `clusters.merge_tree.parts_to_delay_insert` | Int | No | null | Parts to delay insert: Number of active data parts in a table, on exceeding which ClickHouse starts artificially reduce the rate of inserting data into the table. |
| `clusters.merge_tree.parts_to_throw_insert` | Int | No | null | Parts to throw insert: Threshold value of active data parts in a table, on exceeding which ClickHouse throws the 'Too many parts …' exception. |
| `clusters.merge_tree.max_replicated_merges_in_queue` | Int | No | null | Max replicated merges in queue: Maximum number of merge tasks that can be in the ReplicatedMergeTree queue at the same time. |
| `clusters.merge_tree.number_of_free_entries_in_pool_to_lower_max_size_of_merge` | Int | No | null | Number of free entries in pool to lower max size of merge: Threshold value of free entries in the pool. If the number of entries in the pool falls below this value, ClickHouse reduces the maximum size of a data part to merge. This helps handle small merges faster, rather than filling the pool with lengthy merges. |
| `clusters.merge_tree.max_bytes_to_merge_at_min_space_in_pool` | Int | No | null | Max bytes to merge at min space in pool: Maximum total size of a data part to merge when the number of free threads in the background pool is minimum. |
| `clusters.merge_tree.min_bytes_for_wide_part` | Int | No | null | Minimum number of bytes in a data part that can be stored in Wide format. You can set one, both or none of these settings. |
| `clusters.merge_tree.min_rows_for_wide_part` | Int | No | null | Minimum number of rows in a data part that can be stored in Wide format. You can set one, both or none of these settings. |
| `clusters.merge_tree.ttl_only_drop_parts` | String | No | null | Enables or disables complete dropping of data parts where all rows are expired in MergeTree tables. |
| `clusters.merge_tree.merge_with_ttl_timeout` | Int | No | null | Minimum delay in seconds before repeating a merge with delete TTL. Default value: 14400 seconds (4 hours). |
| `clusters.merge_tree.merge_with_recompression_ttl_timeout` | Int | No | null | Minimum delay in seconds before repeating a merge with recompression TTL. Default value: 14400 seconds (4 hours). |
| `clusters.merge_tree.max_parts_in_total` | Int | No | null | Maximum number of parts in all partitions. |
| `clusters.merge_tree.max_number_of_merges_with_ttl_in_pool` | Int | No | null | When there is more than specified number of merges with TTL entries in pool, do not assign new merge with TTL. |
| `clusters.merge_tree.cleanup_delay_period` | Int | No | null | Minimum period to clean old queue logs, blocks hashes and parts. |
| `clusters.merge_tree.max_avg_part_size_for_too_many_parts` | Int | No | null | The too many parts check according to parts_to_delay_insert and parts_to_throw_insert will be active only if the average part size (in the relevant partition) is not larger than the specified threshold. If it is larger than the specified threshold, the INSERTs will be neither delayed or rejected. This allows to have hundreds of terabytes in a single table on a single server if the parts are successfully merged to larger parts. This does not affect the thresholds on inactive parts or total parts. |
| `clusters.merge_tree.min_age_to_force_merge_seconds` | Int | No | null | Merge parts if every part in the range is older than the value of min_age_to_force_merge_seconds. |
| `clusters.merge_tree.min_age_to_force_merge_on_partition_only` | Int | No | null | Whether min_age_to_force_merge_seconds should be applied only on the entire partition and not on subset. |
| `clusters.merge_tree.merge_selecting_sleep_ms` | Int | No | null | Sleep time for merge selecting when no part is selected. A lower setting triggers selecting tasks in background_schedule_pool frequently, which results in a large number of requests to ClickHouse Keeper in large-scale clusters. |
| `clusters.kafka` | List | No | [] | Kafka engine configuration. |
| `clusters.kafka.security_protocol` | String | No | null | Security protocol used to connect to kafka server. |
| `clusters.kafka.sasl_mechanism` | String | No | null | SASL mechanism used in kafka authentication. |
| `clusters.kafka.sasl_username` | String | No | null | Username on kafka server. |
| `clusters.kafka.sasl_password` | String | No | null | User password on kafka server. |
| `clusters.kafka.enable_ssl_certificate_verification` | String | No | null | enable verification of SSL certificates. |
| `clusters.kafka.max_poll_interval_ms` | String | No | null | Maximum allowed time between calls to consume messages (e.g., rd_kafka_consumer_poll()) for high-level consumers. If this interval is exceeded the consumer is considered failed and the group will rebalance in order to reassign the partitions to another consumer group member. |
| `clusters.kafka.session_timeout_ms` | Int | No | null | Client group session and failure detection timeout. The consumer sends periodic heartbeats (heartbeat.interval.ms) to indicate its liveness to the broker. If no hearts are received by the broker for a group member within the session timeout, the broker will remove the consumer from the group and trigger a rebalance. |
| `clusters.kafka_topic` | List | No | [] | MKafka topic connection configuration. |
| `clusters.kafka_topic.name` | String | Yes | - | Kafka topic name. |
| `clusters.kafka_topic.security_protocol` | String | No | null | Security protocol used to connect to kafka server. |
| `clusters.kafka_topic.sasl_mechanism` | String | No | null | SASL mechanism used in kafka authentication. |
| `clusters.kafka_topic.sasl_username` | String | No | null | Username on kafka server. |
| `clusters.kafka_topic.sasl_password` | String | No | null | User password on kafka server. |
| `clusters.kafka_topic.enable_ssl_certificate_verification` | String | No | null | enable verification of SSL certificates. |
| `clusters.kafka_topic.max_poll_interval_ms` | String | No | null | Maximum allowed time between calls to consume messages (e.g., rd_kafka_consumer_poll()) for high-level consumers. If this interval is exceeded the consumer is considered failed and the group will rebalance in order to reassign the partitions to another consumer group member. |
| `clusters.kafka_topic.session_timeout_ms` | Int | No | null | Client group session and failure detection timeout. The consumer sends periodic heartbeats (heartbeat.interval.ms) to indicate its liveness to the broker. If no hearts are received by the broker for a group member within the session timeout, the broker will remove the consumer from the group and trigger a rebalance. |
| `clusters.compression` | List | No | [] | Data compression configuration. |
| `clusters.compression.method` | String | No | null | Method: Compression method. Two methods are available: LZ4 and zstd. |
| `clusters.compression.min_part_size` | String | No | null | Min part size: Minimum size (in bytes) of a data part in a table. ClickHouse only applies the rule to tables with data parts greater than or equal to the Min part size value. |
| `clusters.compression.min_part_size_ratio` | String | No | null | Min part size ratio: Minimum table part size to total table size ratio. ClickHouse only applies the rule to tables in which this ratio is greater than or equal to the Min part size ratio value. |
| `clusters.compression.level` | String | No | null | Compression level for ZSTD method. |
| `clusters.rabbitmq` | List | No | [] | RabbitMQ connection configuration. |
| `clusters.rabbitmq.username` | String | No | null | RabbitMQ username. |
| `clusters.rabbitmq.password` | String | No | null | RabbitMQ user password. |
| `clusters.rabbitmq.vhost` | String | No | null | RabbitMQ vhost. Default: '\'. |
| `clusters.graphite_rollup` | List | No | [] | Graphite rollup configuration. |
| `clusters.graphite_rollup.name` | String | Yes | - | Graphite rollup configuration name. |
| `clusters.graphite_rollup.pattern_function` | String | Yes| - | Aggregation function name. |
| `clusters.graphite_rollup.pattern_regexp` | String | No | null | Regular expression that the metric name must match. |
| `clusters.graphite_rollup.pattern_retention_age` | String | Yes | - | Minimum data age in seconds. |
| `clusters.graphite_rollup.pattern_retention_precision` | String | Yes | - | Accuracy of determining the age of the data in seconds. |
| `clusters.shard` | List | No | [] | Shard configurations. |
| `clusters.shard.name` | String | Yes| - | The name of shard. |
| `clusters.shard.weight` | Int | No | - | The weight of shard. |
| `clusters.shard.resources` | List | No | - | Resources allocated to host of the shard. The resources specified for the shard takes precedence over the resources specified for the cluster. The structure is documented below. |
| `clusters.shard.resources.resources_preset_id` | String | No | null | The ID of the preset for computational resources available to a host (CPU, memory etc.).  |
| `clusters.shard.resources.disk_size` | String | No | null | Volume of the storage available to a host, in gigabytes. |
| `clusters.shard.resources.disk_type_id` | Int | No | null | Type of the storage of hosts. |
| `clusters.shard_group` | List | No | [] | A group of clickhouse shards. |
| `clusters.shard_group.name` | String | Yes | - | The name of the shard group, used as cluster name in Distributed tables. |
| `clusters.shard_group.description` | String | No | "Created by Terraform" | Description of the shard group. |
| `clusters.shard_group.shard_names` | String | Yes | - | List of shards names that belong to the shard group. |
| `clusters.admin_password` | String | No | - | A password used to authorize as user admin when sql_user_management enabled. |
| `clusters.sql_user_management` | String | No | - | Enables admin user with user management permission. |
| `clusters.sql_database_management` | String | No | - | Grants admin user database management permission. |
| `clusters.embedded_keeper` | String | No | - | Whether to use ClickHouse Keeper as a coordination system and place it on the same hosts with ClickHouse. If not, it's used ZooKeeper with placement on separate hosts. |
| `clusters.security_group_ids` | List | No | [] | A set of ids of security groups assigned to hosts of the cluster. |
| `clusters.zookeeper` | List | No | [] | Configuration of the ZooKeeper subcluster. |
| `clusters.zookeeper.resources.resources_preset_id` | String | No | null | The ID of the preset for computational resources available to a host (CPU, memory etc.).  |
| `clusters.zookeeper.resources.disk_size` | String | No | null | Volume of the storage available to a host, in gigabytes. |
| `clusters.zookeeper.resources.disk_type_id` | Int | No | null | Type of the storage of hosts. |
| `clusters.database` | List | No | [] | A database of the ClickHouse cluster. |
| `clusters.database.name` | String | Yes | - | A database name of the ClickHouse cluster. |
| `clusters.user` | List | No | [] | A user of the ClickHouse cluster. |
| `clusters.user.name` | String | Yes | - | The name of the user. |
| `clusters.user.permission` | List | No | [] | Set of permissions granted to the user. The structure is documented below. |
| `clusters.user.permission.database_name` | String | Yes | - | The name of the database that the permission grants access to. |
| `clusters.user.settings` | List | No | [] | Custom settings for user. The list is documented below. |
| `clusters.user.settings.readonly` | String | No | null | Restricts permissions for reading data, write data and change settings queries. |
| `clusters.user.settings.allow_ddl` | Int | No | null | Allows or denies DDL queries. |
| `clusters.user.settings.insert_quorum` | Int | No | null | Enables the quorum writes. |
| `clusters.user.settings.connect_timeout` | Int | No | null | Connect timeout in milliseconds on the socket used for communicating with the client. |
| `clusters.user.settings.receive_timeout` | Int | No | null | Receive timeout in milliseconds on the socket used for communicating with the client. |
| `clusters.user.settings.send_timeout` | Int | No | null | Send timeout in milliseconds on the socket used for communicating with the client. |
| `clusters.user.settings.insert_quorum_timeout` | Int | No | null | Write to a quorum timeout in milliseconds. |
| `clusters.user.settings.select_sequential_consistency` | Int | No | null | Enables or disables sequential consistency for SELECT queries. |
| `clusters.user.settings.max_replica_delay_for_distributed_queries` | Int | No | null | Disables lagging replicas for distributed queries. |
| `clusters.user.settings.fallback_to_stale_replicas_for_distributed_queries` | Int | No | null | Forces a query to an out-of-date replica if updated data is not available. |
| `clusters.user.settings.replication_alter_partitions_sync` | Int | No | null | For ALTER … ATTACH|DETACH|DROP queries, you can use the replication_alter_partitions_sync setting to set up waiting. |
| `clusters.user.settings.distributed_product_mode` | Int | No | null | Changes the behaviour of distributed subqueries. |
| `clusters.user.settings.distributed_aggregation_memory_efficient` | Int | No | null | Determine the behavior of distributed subqueries. |
| `clusters.user.settings.distributed_ddl_task_timeout` | Int | No | null | Timeout for DDL queries, in milliseconds. |
| `clusters.user.settings.skip_unavailable_shards` | Int | No | null | Enables or disables silently skipping of unavailable shards. |
| `clusters.user.settings.compile` | Int | No | null | Enable compilation of queries. |
| `clusters.user.settings.min_count_to_compile` | Int | No | null | How many times to potentially use a compiled chunk of code before running compilation. |
| `clusters.user.settings.compile_expressions` | Int | No | null | Turn on expression compilation. |
| `clusters.user.settings.min_count_to_compile_expression` | Int | No | null | A query waits for expression compilation process to complete prior to continuing execution. |
| `clusters.user.settings.max_block_size` | Int | No | null | A recommendation for what size of the block (in a count of rows) to load from tables. |
| `clusters.user.settings.min_insert_block_size_rows` | Int | No | null | Sets the minimum number of rows in the block which can be inserted into a table by an INSERT query. |
| `clusters.user.settings.min_insert_block_size_bytes` | Int | No | null | Sets the minimum number of bytes in the block which can be inserted into a table by an INSERT query. |
| `clusters.user.settings.max_insert_block_size` | Int | No | null | The size of blocks (in a count of rows) to form for insertion into a table. |
| `clusters.user.settings.min_bytes_to_use_direct_io` | Int | No | null | The minimum data volume required for using direct I/O access to the storage disk. |
| `clusters.user.settings.use_uncompressed_cache` | Int | No | null | Whether to use a cache of uncompressed blocks. |
| `clusters.user.settings.merge_tree_max_rows_to_use_cache` | Int | No | null | If ClickHouse should read more than merge_tree_max_rows_to_use_cache rows in one query, it doesn’t use the cache of uncompressed blocks. |
| `clusters.user.settings.merge_tree_max_bytes_to_use_cache` | Int | No | null | If ClickHouse should read more than merge_tree_max_bytes_to_use_cache bytes in one query, it doesn’t use the cache of uncompressed blocks. |
| `clusters.user.settings.merge_tree_min_rows_for_concurrent_read` | Int | No | null | If the number of rows to be read from a file of a MergeTree table exceeds merge_tree_min_rows_for_concurrent_read then ClickHouse tries to perform a concurrent reading from this file on several threads. |
| `clusters.user.settings.merge_tree_min_bytes_for_concurrent_read` | Int | No | null | If the number of bytes to read from one file of a MergeTree-engine table exceeds merge_tree_min_bytes_for_concurrent_read, then ClickHouse tries to concurrently read from this file in several threads. |
| `clusters.user.settings.max_bytes_before_external_group_by` | Int | No | null | Limit in bytes for using memoru for GROUP BY before using swap on disk. |
| `clusters.user.settings.max_bytes_before_external_sort` | Int | No | null | This setting is equivalent of the max_bytes_before_external_group_by setting, except for it is for sort operation (ORDER BY), not aggregation. |
| `clusters.user.settings.group_by_two_level_threshold` | Int | No | null | Sets the threshold of the number of keys, after that the two-level aggregation should be used. |
| `clusters.user.settings.group_by_two_level_threshold_bytes` | Int | No | null | Sets the threshold of the number of bytes, after that the two-level aggregation should be used. |
| `clusters.user.settings.priority` | Int | No | null | Query priority. |
| `clusters.user.settings.max_threads` | Int | No | null | The maximum number of query processing threads, excluding threads for retrieving data from remote servers. |
| `clusters.user.settings.max_memory_usage` | Int | No | null | Limits the maximum memory usage (in bytes) for processing queries on a single server. |
| `clusters.user.settings.max_memory_usage_for_user` | Int | No | null | Limits the maximum memory usage (in bytes) for processing of user's queries on a single server. |
| `clusters.user.settings.max_network_bandwidth` | Int | No | null | Limits the speed of the data exchange over the network in bytes per second. |
| `clusters.user.settings.max_network_bandwidth_for_user` | Int | No | null | Limits the speed of the data exchange over the network in bytes per second. |
| `clusters.user.settings.force_index_by_date` | Int | No | null | Disables query execution if the index can’t be used by date. |
| `clusters.user.settings.force_primary_key` | Int | No | null | Disables query execution if indexing by the primary key is not possible. |
| `clusters.user.settings.max_rows_to_read` | Int | No | null | Limits the maximum number of rows that can be read from a table when running a query. |
| `clusters.user.settings.max_bytes_to_read` | Int | No | null | Limits the maximum number of bytes (uncompressed data) that can be read from a table when running a query. |
| `clusters.user.settings.read_overflow_mode` | Int | No | null | Sets behaviour on overflow while read. Possible values: |
| `clusters.user.settings.max_rows_to_group_by` | Int | No | null | Limits the maximum number of unique keys received from aggregation function. |
| `clusters.user.settings.group_by_overflow_mode` | Int | No | null | Sets behaviour on overflow while GROUP BY operation. Possible values: |
| `clusters.user.settings.max_rows_to_sort` | Int | No | null | Limits the maximum number of rows that can be read from a table for sorting. |
| `clusters.user.settings.max_bytes_to_sort` | Int | No | null | Limits the maximum number of bytes (uncompressed data) that can be read from a table for sorting. |
| `clusters.user.settings.sort_overflow_mode` | Int | No | null | Sets behaviour on overflow while sort. Possible values: |
| `clusters.user.settings.max_result_rows` | Int | No | null | Limits the number of rows in the result. |
| `clusters.user.settings.max_result_bytes` | Int | No | null | Limits the number of bytes in the result. |
| `clusters.user.settings.result_overflow_mode` | Int | No | null | Sets behaviour on overflow in result. Possible values: |
| `clusters.user.settings.max_rows_in_distinct` | Int | No | null | Limits the maximum number of different rows when using DISTINCT. |
| `clusters.user.settings.max_bytes_in_distinct` | Int | No | null | Limits the maximum size of a hash table in bytes (uncompressed data) when using DISTINCT. |
| `clusters.user.settings.distinct_overflow_mode` | Int | No | null | Sets behaviour on overflow when using DISTINCT. Possible values: |
| `clusters.user.settings.max_rows_to_transfer` | Int | No | null | Limits the maximum number of rows that can be passed to a remote server or saved in a temporary table when using GLOBAL IN. |
| `clusters.user.settings.max_bytes_to_transfer` | Int | No | null | Limits the maximum number of bytes (uncompressed data) that can be passed to a remote server or saved in a temporary table when using GLOBAL IN. |
| `clusters.user.settings.transfer_overflow_mode` | Int | No | null | Sets behaviour on overflow. Possible values: |
| `clusters.user.settings.max_execution_time` | Int | No | null | Limits the maximum query execution time in milliseconds. |
| `clusters.user.settings.timeout_overflow_mode` | Int | No | null | Sets behaviour on overflow. Possible values: |
| `clusters.user.settings.max_rows_in_set` | Int | No | null | Limit on the number of rows in the set resulting from the execution of the IN section. |
| `clusters.user.settings.max_bytes_in_set` | Int | No | null | Limit on the number of bytes in the set resulting from the execution of the IN section. |
| `clusters.user.settings.set_overflow_mode` | Int | No | null | Sets behaviour on overflow in the set resulting. Possible values: |
| `clusters.user.settings.max_rows_in_join` | Int | No | null | Limit on maximum size of the hash table for JOIN, in rows. |
| `clusters.user.settings.max_bytes_in_join` | Int | No | null | Limit on maximum size of the hash table for JOIN, in bytes. |
| `clusters.user.settings.join_overflow_mode` | Int | No | null | Sets behaviour on overflow in JOIN. Possible values: |
| `clusters.user.settings.max_columns_to_read` | Int | No | null | Limits the maximum number of columns that can be read from a table in a single query. |
| `clusters.user.settings.max_temporary_columns` | Int | No | null | Limits the maximum number of temporary columns that must be kept in RAM at the same time when running a query, including constant columns. |
| `clusters.user.settings.max_temporary_non_const_columns` | Int | No | null | Limits the maximum number of temporary columns that must be kept in RAM at the same time when running a query, excluding constant columns. |
| `clusters.user.settings.max_query_size` | Int | No | null | The maximum part of a query that can be taken to RAM for parsing with the SQL parser. |
| `clusters.user.settings.max_ast_depth` | Int | No | null | Maximum abstract syntax tree depth. |
| `clusters.user.settings.max_ast_elements` | Int | No | null | Maximum abstract syntax tree elements. |
| `clusters.user.settings.max_expanded_ast_elements` | Int | No | null | Maximum abstract syntax tree depth after after expansion of aliases. |
| `clusters.user.settings.min_execution_speed` | Int | No | null | Minimal execution speed in rows per second. |
| `clusters.user.settings.min_execution_speed_bytes` | Int | No | null | Minimal execution speed in bytes per second. |
| `clusters.user.settings.count_distinct_implementation` | Int | No | null | Specifies which of the uniq* functions should be used to perform the COUNT(DISTINCT …) construction. |
| `clusters.user.settings.input_format_values_interpret_expressions` | Int | No | null | Enables or disables the full SQL parser if the fast stream parser can’t parse the data. |
| `clusters.user.settings.input_format_defaults_for_omitted_fields` | Int | No | null | When performing INSERT queries, replace omitted input column values with default values of the respective columns. |
| `clusters.user.settings.output_format_json_quote_64bit_integers` | Int | No | null | If the value is true, integers appear in quotes when using JSON* Int64 and UInt64 formats (for compatibility with most JavaScript implementations); otherwise, integers are output without the quotes. |
| `clusters.user.settings.output_format_json_quote_denormals` | Int | No | null | Enables +nan, -nan, +inf, -inf outputs in JSON output format. |
| `clusters.user.settings.low_cardinality_allow_in_native_format` | Int | No | null | Allows or restricts using the LowCardinality data type with the Native format. |
| `clusters.user.settings.empty_result_for_aggregation_by_empty_set` | Int | No | null | Allows to retunr empty result. |
| `clusters.user.settings.joined_subquery_requires_alias` | Int | No | null | Require aliases for subselects and table functions in FROM that more than one table is present. |
| `clusters.user.settings.join_use_nulls` | Int | No | null | Sets the type of JOIN behaviour. When merging tables, empty cells may appear. ClickHouse fills them differently based on this setting. |
| `clusters.user.settings.transform_null_in` | Int | No | null | Enables equality of NULL values for IN operator. |
| `clusters.user.settings.http_connection_timeout` | Int | No | null | Timeout for HTTP connection in milliseconds. |
| `clusters.user.settings.http_receive_timeout` | Int | No | null | Timeout for HTTP connection in milliseconds. |
| `clusters.user.settings.http_send_timeout` | Int | No | null | Timeout for HTTP connection in milliseconds. |
| `clusters.user.settings.enable_http_compression` | Int | No | null | Enables or disables data compression in the response to an HTTP request. |
| `clusters.user.settings.send_progress_in_http_headers` | Int | No | null | Enables or disables X-ClickHouse-Progress HTTP response headers in clickhouse-server responses. |
| `clusters.user.settings.http_headers_progress_interval` | Int | No | null | Sets minimal interval between notifications about request process in HTTP header X-ClickHouse-Progress. |
| `clusters.user.settings.add_http_cors_header` | Int | No | null | Include CORS headers in HTTP responces. |
| `clusters.user.settings.quota_mode` | Int | No | null | Quota accounting mode. |
| `clusters.user.settings.max_concurrent_queries_for_user` | Int | No | null | The maximum number of concurrent requests per user. Default value: 0 (no limit). |
| `clusters.user.settings.memory_profiler_step` | Int | No | null | Memory profiler step (in bytes). If the next query step requires more memory than this parameter specifies, the memory profiler collects the allocating stack trace. Values lower than a few megabytes slow down query processing. Default value: 4194304 (4 MB). Zero means disabled memory profiler. |
| `clusters.user.settings.memory_profiler_sample_probability` | Int | No | null | Collect random allocations and deallocations and write them into system.trace_log with 'MemorySample' trace_type. The probability is for every alloc/free regardless to the size of the allocation. Possible values: from 0 to 1. Default: 0. |
| `clusters.user.settings.insert_null_as_default` | Int | No | null | Enables the insertion of default values instead of NULL into columns with not nullable data type. Default value: true. |
| `clusters.user.settings.allow_suspicious_low_cardinality_types` | Int | No | null | Allows specifying LowCardinality modifier for types of small fixed size (8 or less) in CREATE TABLE statements. Enabling this may increase merge times and memory consumption. |
| `clusters.user.settings.connect_timeout_with_failover` | Int | No | null | The timeout in milliseconds for connecting to a remote server for a Distributed table engine, if the ‘shard’ and ‘replica’ sections are used in the cluster definition. If unsuccessful, several attempts are made to connect to various replicas. Default value: 50. |
| `clusters.user.settings.allow_introspection_functions` | Int | No | null | Enables introspections functions for query profiling. |
| `clusters.user.settings.async_insert` | Int | No | null | Enables asynchronous inserts. Disabled by default. |
| `clusters.user.settings.async_insert_threads` | Int | No | null | The maximum number of threads for background data parsing and insertion. If the parameter is set to 0, asynchronous insertions are disabled. Default value: 16. |
| `clusters.user.settings.wait_for_async_insert` | Int | No | null | Enables waiting for processing of asynchronous insertion. If enabled, server returns OK only after the data is inserted. |
| `clusters.user.settings.wait_for_async_insert_timeout` | Int | No | null | The timeout (in seconds) for waiting for processing of asynchronous insertion. Value must be at least 1000 (1 second). |
| `clusters.user.settings.async_insert_max_data_size` | Int | No | null | The maximum size of the unparsed data in bytes collected per query before being inserted. If the parameter is set to 0, asynchronous insertions are disabled. Default value: 100000. |
| `clusters.user.settings.async_insert_busy_timeout` | Int | No | null | The maximum timeout in milliseconds since the first INSERT query before inserting collected data. If the parameter is set to 0, the timeout is disabled. Default value: 200. |
| `clusters.user.settings.async_insert_stale_timeout` | Int | No | null | The maximum timeout in milliseconds since the last INSERT query before dumping collected data. If enabled, the settings prolongs the async_insert_busy_timeout with every INSERT query as long as async_insert_max_data_size is not exceeded. |
| `clusters.user.settings.timeout_before_checking_execution_speed` | Int | No | null | Timeout (in seconds) between checks of execution speed. It is checked that execution speed is not less that specified in min_execution_speed parameter. Must be at least 1000. |
| `clusters.user.settings.cancel_http_readonly_queries_on_client_close` | Int | No | null | Cancels HTTP read-only queries (e.g. SELECT) when a client closes the connection without waiting for the response. Default value: false. |
| `clusters.user.settings.flatten_nested` | Int | No | null | Sets the data format of a nested columns. |
| `clusters.user.settings.max_http_get_redirects` | Int | No | null | Limits the maximum number of HTTP GET redirect hops for URL-engine tables. |
| `clusters.user.settings.input_format_import_nested_json` | Int | No | null | Enables or disables the insertion of JSON data with nested objects. |
| `clusters.user.settings.input_format_parallel_parsing` | Int | No | null | Enables or disables order-preserving parallel parsing of data formats. Supported only for TSV, TKSV, CSV and JSONEachRow formats. |
| `clusters.user.settings.max_read_buffer_size` | Int | No | null | The maximum size of the buffer to read from the filesystem. |
| `clusters.user.settings.max_final_threads` | Int | No | null | Sets the maximum number of parallel threads for the SELECT query data read phase with the FINAL modifier. |
| `clusters.user.settings.local_filesystem_read_method` | Int | No | null | Method of reading data from local filesystem. Possible values: |
| `clusters.user.settings.remote_filesystem_read_method` | Int | No | null | Method of reading data from remote filesystem, one of: read, threadpool. |
| `clusters.user.settings.max_read_buffer_size` | Int | No | null | The maximum size of the buffer to read from the filesystem. |
| `clusters.user.settings.insert_keeper_max_retries` | Int | No | null | The setting sets the maximum number of retries for ClickHouse Keeper (or ZooKeeper) requests during insert into replicated MergeTree. Only Keeper requests which failed due to network error, Keeper session timeout, or request timeout are considered for retries. |
| `clusters.user.settings.max_temporary_data_on_disk_size_for_user` | Int | No | null | The maximum amount of data consumed by temporary files on disk in bytes for all concurrently running user queries. Zero means unlimited. |
| `clusters.user.settings.max_temporary_data_on_disk_size_for_query` | Int | No | null | The maximum amount of data consumed by temporary files on disk in bytes for all concurrently running queries. Zero means unlimited. |
| `clusters.user.settings.max_parser_depth` | Int | No | null | Limits maximum recursion depth in the recursive descent parser. Allows controlling the stack size. Zero means unlimited. |
| `clusters.user.settings.memory_overcommit_ratio_denominator` | Int | No | null | It represents soft memory limit in case when hard limit is reached on user level. This value is used to compute overcommit ratio for the query. Zero means skip the query. |
| `clusters.user.settings.memory_overcommit_ratio_denominator_for_user` | Int | No | null | It represents soft memory limit in case when hard limit is reached on global level. This value is used to compute overcommit ratio for the query. Zero means skip the query. |
| `clusters.user.settings.memory_usage_overcommit_max_wait_microseconds` | Int | No | null | Maximum time thread will wait for memory to be freed in the case of memory overcommit on a user level. If the timeout is reached and memory is not freed, an exception is thrown. |
| `clusters.user.quota` | List | No | [] | Set of user quotas. The structure is documented below. |
| `clusters.user.quota.interval_duration` | Int | Yes | null | Duration of interval for quota in milliseconds. |
| `clusters.user.quota.queries` | Int | No | null | The total number of queries. |
| `clusters.user.quota.errors` | Int | No | null | The number of queries that threw exception. |
| `clusters.user.quota.result_rows` | Int | No | null | The total number of rows given as the result. |
| `clusters.user.quota.read_rows` | Int | No | null | The total number of source rows read from tables for running the query, on all remote servers. |
| `clusters.user.quota.execution_time` | Int | No | null | The total query execution time, in milliseconds (wall time). |
| `clusters.user.clickhouse_hosts` | List | No | [] | Set of hosts quotas. The structure is documented below. |
| `clusters.user.clickhouse_hosts.fqdn` | String | No | null | The fully qualified domain name of the host. |
| `clusters.user.clickhouse_hosts.type` | String | Yes | null | The type of the host to be deployed. Can be either CLICKHOUSE or ZOOKEEPER. |
| `clusters.user.clickhouse_hosts.zone` | String | Yes | null | The availability zone where the ClickHouse host will be created. For more information see the official documentation. |
| `clusters.user.clickhouse_hosts.subnet_id` | String | No | null | The ID of the subnet, to which the host belongs. The subnet must be a part of the network to which the cluster belongs. |
| `clusters.user.clickhouse_hosts.shard_name` | String | No | null | The name of the shard to which the host belongs. |
| `clusters.user.clickhouse_hosts.assign_public_ip` | Bool | No | null | Sets whether the host should get a public IP address on creation. Can be either true or false. |
| `clusters.user.clickhouse_hosts.web_sql` | Bool | No | null | Allow access for Web SQL. Can be either true or false. |
| `clusters.user.clickhouse_hosts.data_lens` | Bool | No | null | Allow access for DataLens. Can be either true or false. |
| `clusters.user.clickhouse_hosts.metrika` | Bool | No | null | Allow access for Yandex.Metrika. Can be either true or false. |
| `clusters.user.clickhouse_hosts.serverless` | Bool | No | null | Allow access for Serverless. Can be either true or false. |
| `clusters.user.clickhouse_hosts.yandex_query` | Bool | No | null | Allow access for YandexQuery. Can be either true or false. |
| `clusters.user.clickhouse_hosts.data_transfer` | Bool | No | null | Allow access for DataTransfer. Can be either true or false. |
| `clusters.service_account_id` | String | No | null | ID of the service account used for access to Yandex Object Storage. |
| `clusters.cloud_storage_enable` | Bool | No | false | Whether to use Yandex Object Storage for storing ClickHouse data. Can be either true or false. |
| `clusters.maintenance_window_type` | String | No | "ANYTIME" | Type of maintenance window. Can be either ANYTIME or WEEKLY. A day and hour of window need to be specified with weekly window. |
| `clusters.maintenance_window_hour` | Int | No | null | Hour of day in UTC time zone (1-24) for maintenance window if window type is weekly. |
| `clusters.maintenance_window_day` | Int | No | null | Day of week for maintenance window if window type is weekly. Possible values: MON, TUE, WED, THU, FRI, SAT, SUN. |

## Example

Usage example located in this [directory](docs/example).
