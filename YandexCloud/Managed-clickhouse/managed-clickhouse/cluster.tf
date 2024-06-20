## Create Clickhouse cluster

resource "yandex_mdb_clickhouse_cluster" "cluster" {
  for_each = var.clusters

  name                = each.key
  environment         = try(each.value.environment, "PRODUCTION")
  description         = try(each.value.description, "Created by Terraform")
  network_id          = each.value.network_id
  version             = try(each.value.clickhouse_version, null)
  deletion_protection = try(each.value.deletion_protection, false)

  clickhouse {
    resources {
      resource_preset_id = each.value.resource_preset_id
      disk_type_id       = try(each.value.disk_type_id, "network-hdd")
      disk_size          = try(each.value.disk_size, 10)
    }

    config {
      log_level                       = try(each.value.config_log_level , "TRACE")
      max_connections                 = try(each.value.config_max_connections , 100)
      max_concurrent_queries          = try(each.value.config_max_concurrent_queries , 50)
      keep_alive_timeout              = try(each.value.config_keep_alive_timeout , 3000)
      uncompressed_cache_size         = try(each.value.config_uncompressed_cache_size , 8589934592)
      mark_cache_size                 = try(each.value.config_mark_cache_size , 5368709120)
      max_table_size_to_drop          = try(each.value.config_max_table_size_to_drop , 53687091200)
      max_partition_size_to_drop      = try(each.value.config_max_partition_size_to_drop , 53687091200)
      timezone                        = try(each.value.config_timezone , "UTC")
      geobase_uri                     = try(each.value.config_geobase_uri , "")
      query_log_retention_size        = try(each.value.config_query_log_retention_size , 1073741824)
      query_log_retention_time        = try(each.value.config_query_log_retention_time , 259200000)
      query_thread_log_enabled        = try(each.value.config_query_thread_log_enabled , true)
      query_thread_log_retention_size = try(each.value.config_query_thread_log_retention_size , 536870912)
      query_thread_log_retention_time = try(each.value.config_query_thread_log_retention_time , 259200000)
      part_log_retention_size         = try(each.value.config_part_log_retention_size , 536870912)
      part_log_retention_time         = try(each.value.config_part_log_retention_time , 259200000)
      metric_log_enabled              = try(each.value.config_metric_log_enabled , true)
      metric_log_retention_size       = try(each.value.config_metric_log_retention_size , 536870912)
      metric_log_retention_time       = try(each.value.config_metric_log_retention_time , 259200000)
      trace_log_enabled               = try(each.value.config_trace_log_enabled , true)
      trace_log_retention_size        = try(each.value.config_trace_log_retention_size , 536870912)
      trace_log_retention_time        = try(each.value.config_trace_log_retention_time , 259200000)
      text_log_enabled                = try(each.value.config_text_log_enabled , true)
      text_log_retention_size         = try(each.value.config_text_log_retention_size , 536870912)
      text_log_retention_time         = try(each.value.config_text_log_retention_time , 259200000)
      text_log_level                  = try(each.value.config_text_log_level , "TRACE")
      background_pool_size            = try(each.value.config_background_pool_size , 16)
      background_schedule_pool_size   = try(each.value.config_background_schedule_pool_size , 16)

      dynamic "merge_tree" {
        for_each = try(each.value.merge_tree, [])
        content {
          replicated_deduplication_window                           = try(merge_tree.value.replicated_deduplication_window, null)
          replicated_deduplication_window_seconds                   = try(merge_tree.value.replicated_deduplication_window_seconds, null)
          parts_to_delay_insert                                     = try(merge_tree.value.parts_to_delay_insert, null)
          parts_to_throw_insert                                     = try(merge_tree.value.parts_to_throw_insert, null)
          max_replicated_merges_in_queue                            = try(merge_tree.value.max_replicated_merges_in_queue, null)
          number_of_free_entries_in_pool_to_lower_max_size_of_merge = try(merge_tree.value.number_of_free_entries_in_pool_to_lower_max_size_of_merge, null)
          max_bytes_to_merge_at_min_space_in_pool                   = try(merge_tree.value.max_bytes_to_merge_at_min_space_in_pool, null)
          min_bytes_for_wide_part                                   = try(merge_tree.value.min_bytes_for_wide_part, null)
          min_rows_for_wide_part                                    = try(merge_tree.value.min_rows_for_wide_part, null)
          ttl_only_drop_parts                                       = try(merge_tree.value.ttl_only_drop_parts, null)
          merge_with_ttl_timeout                                    = try(merge_tree.value.merge_with_ttl_timeout, null)
          merge_with_recompression_ttl_timeout                      = try(merge_tree.value.merge_with_recompression_ttl_timeout, null)
          max_parts_in_total                                        = try(merge_tree.value.max_parts_in_total, null)
          max_number_of_merges_with_ttl_in_pool                     = try(merge_tree.value.max_number_of_merges_with_ttl_in_pool, null)
          cleanup_delay_period                                      = try(merge_tree.value.cleanup_delay_period, null)
          max_avg_part_size_for_too_many_parts                      = try(merge_tree.value.max_avg_part_size_for_too_many_parts, null)
          min_age_to_force_merge_seconds                            = try(merge_tree.value.min_age_to_force_merge_seconds, null)
          min_age_to_force_merge_on_partition_only                  = try(merge_tree.value.min_age_to_force_merge_on_partition_only, null)
          merge_selecting_sleep_ms                                  = try(merge_tree.value.merge_selecting_sleep_ms, null)
        }
      }

      dynamic "kafka" {
        for_each = try(each.value.kafka, [])
        content {
          security_protocol                   = try(kafka.value.security_protocol, null)
          sasl_mechanism                      = try(kafka.value.sasl_mechanism, null)
          sasl_username                       = try(kafka.value.sasl_username, null)
          sasl_password                       = try(kafka.value.sasl_password, null)
          enable_ssl_certificate_verification = try(kafka.value.enable_ssl_certificate_verification, null)
          max_poll_interval_ms                = try(kafka.value.max_poll_interval_ms, null)
          session_timeout_ms                  = try(kafka.value.session_timeout_ms, null)
        }
      }

      dynamic "kafka_topic" {
        for_each = try(each.value.kafka_topic, [])
        content {
          name = kafka_topic.value.name
          settings {
            security_protocol                   = try(kafka_topic.value.security_protocol, null)
            sasl_mechanism                      = try(kafka_topic.value.sasl_mechanism, null)
            sasl_username                       = try(kafka_topic.value.sasl_username, null)
            sasl_password                       = try(kafka_topic.value.sasl_password, null)
            enable_ssl_certificate_verification = try(kafka_topic.value.enable_ssl_certificate_verification, null)
            max_poll_interval_ms                = try(kafka_topic.value.max_poll_interval_ms, null)
            session_timeout_ms                  = try(kafka_topic.value.session_timeout_ms, null)
          }
        }
      }

      dynamic "rabbitmq" {
        for_each = try(each.value.rabbitmq, [])
        content {
          username = try(rabbitmq.value.username, null)
          password = try(rabbitmq.value.password, null)
          vhost    = try(rabbitmq.value.vhost, null)
        }
      }

      dynamic "compression" {
        for_each = try(each.value.compression, [])
        content {
          method              = try(compression.value.method, null)
          min_part_size       = try(compression.value.min_part_size, null)
          min_part_size_ratio = try(compression.value.min_part_size_ratio, null)
          level               = try(compression.value.level, null)
        }
      }

      dynamic "graphite_rollup" {
        for_each = try(each.value.graphite_rollup, [])
        content {
          name = graphite_rollup.value.name
          pattern {
            regexp   = graphite_rollup.value.pattern_regexp
            function = graphite_rollup.value.pattern_function
            retention {
              age       = graphite_rollup.value.pattern_retention_age
              precision = graphite_rollup.value.pattern_retention_precision
            }
          }
        }
      }

    }
  }

  dynamic "shard" {
    for_each = try(each.value.shard, [])
    content {
      name = shard.value.name
      weight = try(shard.value.weight, null)
      dynamic "resources" {
        for_each = try(shard.value.resources, [])
        content {
          resource_preset_id = try(resources.value.resource_preset_id, null)
          disk_type_id       = try(resources.value.disk_type, null)
          disk_size          = try(resources.value.disk_size, null)
        }
      }
    }
  }

  dynamic "shard_group" {
    for_each = try(each.value.shard_group, [])
    content {
      name        = shard_group.value.name
      description = try(shard_group.value.description, "Created by Terraform")
      shard_names = shard_group.value.shard_names
    }
  }

  admin_password          = try(each.value.admin_password, random_password.admin_pass.result, null)
  sql_user_management     = try(each.value.sql_user_management, null)
  sql_database_management = try(each.value.sql_database_management, null)
  security_group_ids      = try(each.value.security_group_ids, [])
  embedded_keeper         = try(each.value.clickhouse_keeper_enable, null)

  dynamic "zookeeper" {
    for_each = try(each.value.zookeeper, [])
    content {
      resources {
        resource_preset_id = try(zookeeper.value.resource_preset_id, null)
        disk_type_id       = try(zookeeper.value.disk_type_id, null)
        disk_size          = try(zookeeper.value.disk_size, null)
      }
    }
  }

  dynamic "database" {
    for_each = try(each.value.database, [])
    content {
      name = database.value.name
    }
  }

  dynamic "user" {
    for_each = try(each.value.user, [])
    content {
      name     = user.value.name
      password = random_password.user_pass[user.value.name].result

      dynamic "permission" {
        for_each = try(user.value.permission, [])
        content {
          database_name = permission.value.database_name
        }
      }
      dynamic "settings" {
        for_each = try(user.value.settings, [])
        content {
          readonly                                             = try(settings.value.readonly, null)
          allow_ddl                                            = try(settings.value.allow_ddl, null)
          insert_quorum                                        = try(settings.value.insert_quorum, null)
          connect_timeout                                      = try(settings.value.connect_timeout, null)
          receive_timeout                                      = try(settings.value.receive_timeout, null)
          send_timeout                                         = try(settings.value.send_timeout, null)
          insert_quorum_timeout                                = try(settings.value.insert_quorum_timeout, null)
          select_sequential_consistency                        = try(settings.value.select_sequential_consistency, null)
          max_replica_delay_for_distributed_queries            = try(settings.value.max_replica_delay_for_distributed_queries, null)
          fallback_to_stale_replicas_for_distributed_queries   = try(settings.value.fallback_to_stale_replicas_for_distributed_queries, null)
          replication_alter_partitions_sync                    = try(settings.value.replication_alter_partitions_sync, null)
          distributed_product_mode                             = try(settings.value.distributed_product_mode, null)
          distributed_aggregation_memory_efficient             = try(settings.value.distributed_aggregation_memory_efficient, null)
          distributed_ddl_task_timeout                         = try(settings.value.distributed_ddl_task_timeout, null)
          skip_unavailable_shards                              = try(settings.value.skip_unavailable_shards, null)
          compile                                              = try(settings.value.compile, null)
          min_count_to_compile                                 = try(settings.value.min_count_to_compile, null)
          compile_expressions                                  = try(settings.value.compile_expressions, null)
          min_count_to_compile_expression                      = try(settings.value.min_count_to_compile_expression, null)
          max_block_size                                       = try(settings.value.max_block_size, null)
          min_insert_block_size_rows                           = try(settings.value.min_insert_block_size_rows, null)
          min_insert_block_size_bytes                          = try(settings.value.min_insert_block_size_bytes, null)
          max_insert_block_size                                = try(settings.value.max_insert_block_size, null)
          min_bytes_to_use_direct_io                           = try(settings.value.min_bytes_to_use_direct_io, null)
          use_uncompressed_cache                               = try(settings.value.use_uncompressed_cache, null)
          merge_tree_max_rows_to_use_cache                     = try(settings.value.merge_tree_max_rows_to_use_cache, null)
          merge_tree_max_bytes_to_use_cache                    = try(settings.value.merge_tree_max_bytes_to_use_cache, null)
          merge_tree_min_rows_for_concurrent_read              = try(settings.value.merge_tree_min_rows_for_concurrent_read, null)
          merge_tree_min_bytes_for_concurrent_read             = try(settings.value.merge_tree_min_bytes_for_concurrent_read, null)
          max_bytes_before_external_group_by                   = try(settings.value.max_bytes_before_external_group_by, null)
          max_bytes_before_external_sort                       = try(settings.value.max_bytes_before_external_sort, null)
          group_by_two_level_threshold                         = try(settings.value.group_by_two_level_threshold, null)
          group_by_two_level_threshold_bytes                   = try(settings.value.group_by_two_level_threshold_bytes, null)
          priority                                             = try(settings.value.priority, null)
          max_threads                                          = try(settings.value.max_threads, null)
          max_memory_usage                                     = try(settings.value.max_memory_usage, null)
          max_memory_usage_for_user                            = try(settings.value.max_memory_usage_for_user, null)
          max_network_bandwidth                                = try(settings.value.max_network_bandwidth, null)
          max_network_bandwidth_for_user                       = try(settings.value.max_network_bandwidth_for_user, null)
          force_index_by_date                                  = try(settings.value.force_index_by_date, null)
          force_primary_key                                    = try(settings.value.force_primary_key, null)
          max_rows_to_read                                     = try(settings.value.max_rows_to_read, null)
          max_bytes_to_read                                    = try(settings.value.max_bytes_to_read, null)
          read_overflow_mode                                   = try(settings.value.read_overflow_mode, null)
          max_rows_to_group_by                                 = try(settings.value.max_rows_to_group_by, null)
          group_by_overflow_mode                               = try(settings.value.group_by_overflow_mode, null)
          max_rows_to_sort                                     = try(settings.value.max_rows_to_sort, null)
          max_bytes_to_sort                                    = try(settings.value.max_bytes_to_sort, null)
          sort_overflow_mode                                   = try(settings.value.sort_overflow_mode, null)
          max_result_rows                                      = try(settings.value.max_result_rows, null)
          max_result_bytes                                     = try(settings.value.max_result_bytes, null)
          result_overflow_mode                                 = try(settings.value.result_overflow_mode, null)
          max_rows_in_distinct                                 = try(settings.value.max_rows_in_distinct, null)
          max_bytes_in_distinct                                = try(settings.value.max_bytes_in_distinct, null)
          distinct_overflow_mode                               = try(settings.value.distinct_overflow_mode, null)
          max_rows_to_transfer                                 = try(settings.value.max_rows_to_transfer, null)
          max_bytes_to_transfer                                = try(settings.value.max_bytes_to_transfer, null)
          transfer_overflow_mode                               = try(settings.value.transfer_overflow_mode, null)
          max_execution_time                                   = try(settings.value.max_execution_time, null)
          timeout_overflow_mode                                = try(settings.value.timeout_overflow_mode, null)
          max_rows_in_set                                      = try(settings.value.max_rows_in_set, null)
          max_bytes_in_set                                     = try(settings.value.max_bytes_in_set, null)
          set_overflow_mode                                    = try(settings.value.set_overflow_mode, null)
          max_rows_in_join                                     = try(settings.value.max_rows_in_join, null)
          max_bytes_in_join                                    = try(settings.value.max_bytes_in_join, null)
          join_overflow_mode                                   = try(settings.value.join_overflow_mode, null)
          max_columns_to_read                                  = try(settings.value.max_columns_to_read, null)
          max_temporary_columns                                = try(settings.value.max_temporary_columns, null)
          max_temporary_non_const_columns                      = try(settings.value.max_temporary_non_const_columns, null)
          max_query_size                                       = try(settings.value.max_query_size, null)
          max_ast_depth                                        = try(settings.value.max_ast_depth, null)
          max_ast_elements                                     = try(settings.value.max_ast_elements, null)
          max_expanded_ast_elements                            = try(settings.value.max_expanded_ast_elements, null)
          min_execution_speed                                  = try(settings.value.min_execution_speed, null)
          min_execution_speed_bytes                            = try(settings.value.min_execution_speed_bytes, null)
          count_distinct_implementation                        = try(settings.value.count_distinct_implementation, null)
          input_format_values_interpret_expressions            = try(settings.value.input_format_values_interpret_expressions, null)
          input_format_defaults_for_omitted_fields             = try(settings.value.input_format_defaults_for_omitted_fields, null)
          output_format_json_quote_64bit_integers              = try(settings.value.output_format_json_quote_64bit_integers, null)
          output_format_json_quote_denormals                   = try(settings.value.output_format_json_quote_denormals, null)
          low_cardinality_allow_in_native_format               = try(settings.value.low_cardinality_allow_in_native_format, null)
          empty_result_for_aggregation_by_empty_set            = try(settings.value.empty_result_for_aggregation_by_empty_set, null)
          joined_subquery_requires_alias                       = try(settings.value.joined_subquery_requires_alias, null)
          join_use_nulls                                       = try(settings.value.join_use_nulls, null)
          transform_null_in                                    = try(settings.value.transform_null_in, null)
          http_connection_timeout                              = try(settings.value.http_connection_timeout, null)
          http_receive_timeout                                 = try(settings.value.http_receive_timeout, null)
          http_send_timeout                                    = try(settings.value.http_send_timeout, null)
          enable_http_compression                              = try(settings.value.enable_http_compression, null)
          send_progress_in_http_headers                        = try(settings.value.send_progress_in_http_headers, null)
          http_headers_progress_interval                       = try(settings.value.http_headers_progress_interval, null)
          add_http_cors_header                                 = try(settings.value.add_http_cors_header, null)
          quota_mode                                           = try(settings.value.quota_mode, null)
          max_concurrent_queries_for_user                      = try(settings.value.max_concurrent_queries_for_user, null)
          memory_profiler_step                                 = try(settings.value.memory_profiler_step, null)
          memory_profiler_sample_probability                   = try(settings.value.memory_profiler_sample_probability, null)
          insert_null_as_default                               = try(settings.value.insert_null_as_default, null)
          allow_suspicious_low_cardinality_types               = try(settings.value.allow_suspicious_low_cardinality_types, null)
          connect_timeout_with_failover                        = try(settings.value.connect_timeout_with_failover, null)
          allow_introspection_functions                        = try(settings.value.allow_introspection_functions, null)
          async_insert                                         = try(settings.value.async_insert, null)
          async_insert_threads                                 = try(settings.value.async_insert_threads, null)
          wait_for_async_insert                                = try(settings.value.wait_for_async_insert, null)
          wait_for_async_insert_timeout                        = try(settings.value.wait_for_async_insert_timeout, null)
          async_insert_max_data_size                           = try(settings.value.async_insert_max_data_size, null)
          async_insert_busy_timeout                            = try(settings.value.async_insert_busy_timeout, null)
          async_insert_stale_timeout                           = try(settings.value.async_insert_stale_timeout, null)
          timeout_before_checking_execution_speed              = try(settings.value.timeout_before_checking_execution_speed, null)
          cancel_http_readonly_queries_on_client_close         = try(settings.value.cancel_http_readonly_queries_on_client_close, null)
          flatten_nested                                       = try(settings.value.flatten_nested, null)
          max_http_get_redirects                               = try(settings.value.max_http_get_redirects, null)
          input_format_import_nested_json                      = try(settings.value.input_format_import_nested_json, null)
          input_format_parallel_parsing                        = try(settings.value.input_format_parallel_parsing, null)
          max_final_threads                                    = try(settings.value.max_final_threads, null)
          local_filesystem_read_method                         = try(settings.value.local_filesystem_read_method, null)
          remote_filesystem_read_method                        = try(settings.value.remote_filesystem_read_method, null)
          max_read_buffer_size                                 = try(settings.value.max_read_buffer_size, null)
          insert_keeper_max_retries                            = try(settings.value.insert_keeper_max_retries, null)
          max_temporary_data_on_disk_size_for_user             = try(settings.value.max_temporary_data_on_disk_size_for_user, null)
          max_temporary_data_on_disk_size_for_query            = try(settings.value.max_temporary_data_on_disk_size_for_query, null)
          max_parser_depth                                     = try(settings.value.max_parser_depth, null)
          memory_overcommit_ratio_denominator                  = try(settings.value.memory_overcommit_ratio_denominator, null)
          memory_overcommit_ratio_denominator_for_user         = try(settings.value.memory_overcommit_ratio_denominator_for_user, null)
          memory_usage_overcommit_max_wait_microseconds        = try(settings.value.memory_usage_overcommit_max_wait_microseconds, null)
        }
      }
      dynamic "quota" {
        for_each = try(user.value.quota, [])
        content {
          interval_duration = quota.value.interval_duration
          queries           = quota.value.queries
          errors            = quota.value.errors
          result_rows       = quota.value.result_rows
          read_rows         = quota.value.read_rows
          execution_time    = quota.value.execution_time
        }
      }
    }
  }

  dynamic "host" {
    for_each = try(each.value.clickhouse_hosts, [])
    content {
      type              = host.value.type
      subnet_id         = try(host.value.subnet_id, null)
      zone              = host.value.zone
      fqdn              = try(host.value.fqdn, null)
      shard_name        = try(host.value.shard_name, null)
      assign_public_ip  = try(host.value.assign_public_ip, null)
    }
  }

  access {
    web_sql       = try(each.value.acess_web_sql, false)
    data_lens     = try(each.value.acess_data_lens, false)
    metrika       = try(each.value.acess_metrika, false)
    serverless    = try(each.value.acess_serverless, false)
    yandex_query  = try(each.value.acess_yandex_query, false)
    data_transfer = try(each.value.acess_data_transfer, false)
  }

  service_account_id = try(each.value.service_account_id, null)

  cloud_storage {
    enabled = try(each.value.cloud_storage_enable, false)
  }

  maintenance_window {
    type = try(each.value.maintenance_window_type, "ANYTIME")
    day  = try(each.value.maintenance_window_day, null)
    hour = try(each.value.maintenance_window_hour, null)
  }
}
