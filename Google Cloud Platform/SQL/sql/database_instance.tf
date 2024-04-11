resource "google_sql_database_instance" "database_instance" {
  for_each = var.database_instances

  name                   = each.key
  region                 = try(each.value.region , null)
  project                = try(each.value.project , null)
  database_version       = each.value.database_version
  maintenance_version    = try(each.value.maintenance_version, null)
  master_instance_name   = try(each.value.master_instance_name , null)
  root_password          = try(each.value.root_password , null)
  encryption_key_name    = try(each.value.encryption_key_name , null)
  deletion_protection    = try(each.value.deletion_protection , null)

  dynamic "settings" {
    for_each = try(each.value.settings, [])
    content {
      tier                        = settings.value.tier
      edition                     = try(settings.value.edition, null)
      user_labels                 = try(settings.value.user_labels, {})
      activation_policy           = try(settings.value.activation_policy , null)
      availability_type           = try(settings.value.availability_type , null)
      collation                   = try(settings.value.collation , null)
      connector_enforcement       = try(settings.value.connector_enforcement , null)
      deletion_protection_enabled = try(settings.value.deletion_protection_enabled , null)
      disk_autoresize             = try(settings.value.disk_autoresize , null)
      disk_autoresize_limit       = try(settings.value.disk_autoresize_limit , null)
      disk_size                   = try(settings.value.disk_size , null)
      disk_type                   = try(settings.value.disk_type , null)
      pricing_plan                = try(settings.value.pricing_plan , null)
      time_zone                   = try(settings.value.time_zone , null)

      dynamic "advanced_machine_features" {
        for_each = try(settings.value.advanced_machine_features, [])
        content {
          threads_per_core        = try(advanced_machine_features.value.threads_per_core, null)
        }
      }

      dynamic "database_flags" {
        for_each = try(settings.value.database_flags, [])
        content {
          name                    = database_flags.value.name
          value                   = database_flags.value.value
        }
      }

      dynamic "active_directory_config" {
        for_each = try(settings.value.active_directory_config, [])
        content {
          domain                  = active_directory_config.value.domain
        }
      }

      dynamic "data_cache_config" {
        for_each = try(settings.value.data_cache_config, [])
        content {
          data_cache_enabled      = try(data_cache_config.value.data_cache_enabled, false)
        }
      }

      dynamic "deny_maintenance_period" {
        for_each = try(settings.value.deny_maintenance_period, [])
        content {
          end_date                = deny_maintenance_period.value.end_date
          start_date              = deny_maintenance_period.value.start_date
          time                    = deny_maintenance_period.value.time
        }
      }

      dynamic "sql_server_audit_config" {
        for_each = try(settings.value.sql_server_audit_config, [])
        content {
          bucket                  = try(sql_server_audit_config.value.bucket , null)
          upload_interval         = try(sql_server_audit_config.value.upload_interval , null)
          retention_interval      = try(sql_server_audit_config.value.retention_interval , null)
        }
      }

      dynamic "backup_configuration" {
        for_each = try(settings.value.backup_configuration, [])
        content {
          binary_log_enabled             = try(backup_configuration.value.binary_log_enabled , null)
          enabled                        = try(backup_configuration.value.enabled , null)
          start_time                     = try(backup_configuration.value.start_time , null)
          point_in_time_recovery_enabled = try(backup_configuration.value.point_in_time_recovery_enabled , null)
          location                       = try(backup_configuration.value.location , null)
          transaction_log_retention_days = try(backup_configuration.value.transaction_log_retention_days , null)

          dynamic "backup_retention_settings" {
            for_each = try(backup_configuration.value.backup_retention_settings, [])
            content {
              retained_backups  = try(backup_retention_settings.value.retained_backups , null)
              retention_unit    = try(backup_retention_settings.value.retention_unit , null)
            }
          }

        }
      }

      dynamic "ip_configuration" {
        for_each = try(settings.value.ip_configuration, [])
        content {
          ipv4_enabled                                  = try(ip_configuration.value.ipv4_enabled , null)
          private_network                               = try(ip_configuration.value.private_network , null)
          require_ssl                                   = try(ip_configuration.value.require_ssl , null)
          ssl_mode                                      = try(ip_configuration.value.ssl_mode , null)
          allocated_ip_range                            = try(ip_configuration.value.allocated_ip_range , null)
          enable_private_path_for_google_cloud_services = try(ip_configuration.value.enable_private_path_for_google_cloud_services , null)

          dynamic "authorized_networks" {
            for_each = try(ip_configuration.value.authorized_networks, [])
            content {
              expiration_time  = try(authorized_networks.value.expiration_time, null)
              name             = try(authorized_networks.value.name, null)
              value            = authorized_networks.value.value
            }
          }

          dynamic "psc_config" {
            for_each = try(ip_configuration.value.psc_config, [])
            content {
              psc_enabled               = try(psc_config.value.psc_enabled , null)
              allowed_consumer_projects = try(psc_config.value.allowed_consumer_projects , [])
            }
          }
        }
      }

      dynamic "location_preference" {
        for_each = try(settings.value.location_preference, [])
        content {
          follow_gae_application = try(location_preference.value.follow_gae_application , null)
          zone                   = try(location_preference.value.zone , null)
          secondary_zone         = try(location_preference.value.secondary_zone , null)
        }
      }

      dynamic "maintenance_window" {
        for_each = try(settings.value.maintenance_window, [])
        content {
          day           = try(maintenance_window.value.day , null)
          hour          = try(maintenance_window.value.hour , null)
          update_track  = try(maintenance_window.value.update_track , null)
        }
      }

      dynamic "insights_config" {
        for_each = try(settings.value.insights_config, [])
        content {
          query_insights_enabled  = try(insights_config.value.query_insights_enabled , null)
          query_string_length     = try(insights_config.value.query_string_length , null)
          record_application_tags = try(insights_config.value.record_application_tags , null)
          record_client_address   = try(insights_config.value.record_client_address , null)
          query_plans_per_minute  = try(insights_config.value.query_plans_per_minute , null)
        }
      }

      dynamic "password_validation_policy" {
        for_each = try(settings.value.password_validation_policy, [])
        content {
          min_length                  = try(password_validation_policy.value.min_length , null)
          complexity                  = try(password_validation_policy.value.complexity , null)
          reuse_interval              = try(password_validation_policy.value.reuse_interval , null)
          disallow_username_substring = try(password_validation_policy.value.disallow_username_substring , null)
          password_change_interval    = try(password_validation_policy.value.password_change_interval , null)
          enable_password_policy      = try(password_validation_policy.value.enable_password_policy , null)
        }
      }

    }
  }

  dynamic "replica_configuration" {
    for_each = try(each.value.master_instance_name , null) != "" ? try(each.value.replica_configuration, []) : []
    content {
      ca_certificate            = try(replica_configuration.value.ca_certificate , null)
      client_certificate        = try(replica_configuration.value.client_certificate , null)
      client_key                = try(replica_configuration.value.client_key , null)
      connect_retry_interval    = try(replica_configuration.value.connect_retry_interval , null)
      dump_file_path            = try(replica_configuration.value.dump_file_path , null)
      failover_target           = try(replica_configuration.value.failover_target , null)
      master_heartbeat_period   = try(replica_configuration.value.master_heartbeat_period , null)
      password                  = try(replica_configuration.value.password , null)
      ssl_cipher                = try(replica_configuration.value.ssl_cipher , null)
      username                  = try(replica_configuration.value.username , null)
      verify_server_certificate = try(replica_configuration.value.verify_server_certificate , null)
    }
  }

  dynamic "clone" {
    for_each =  try(each.value.clone, [])
    content {
      source_instance_name = clone.value.source_instance_name
      point_in_time        = try(clone.value.point_in_time , null)
      preferred_zone       = try(clone.value.preferred_zone , null)
      database_names       = try(clone.value.database_names , null)
      allocated_ip_range   = try(clone.value.allocated_ip_range , null)
    }
  }

  dynamic "restore_backup_context" {
    for_each = try(each.value.restore_backup_context, [])
    content {
      backup_run_id = try(restore_backup_context.value.backup_run_id , null)
      instance_id   = try(restore_backup_context.value.instance_id , null)
      project       = try(restore_backup_context.value.project , null)
    }
  }
}