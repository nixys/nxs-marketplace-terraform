###Create DCS
resource "sbercloud_dcs_parameters" "parameters" {
  for_each = var.instances

  instance_id = sbercloud_dcs_instance.instance[each.key].id
  project_id  = try(each.value.project_id, var.general_project_id)

  parameters = {
    timeout                                       = try(each.value.parameters_timeout, null)
    maxmemory-policy                              = try(each.value.parameters_maxmemory-policy, null)
    hash-max-ziplist-entries                      = each.value.engine == "Redis" ? try(each.value.parameters_hash-max-ziplist-entries, null)  : null
    hash-max-ziplist-value                        = each.value.engine == "Redis" ? try(each.value.parameters_hash-max-ziplist-value, null)    : null
    set-max-intset-entries                        = each.value.engine == "Redis" ? try(each.value.parameters_set-max-intset-entries, null)    : null
    zset-max-ziplist-entries                      = each.value.engine == "Redis" ? try(each.value.parameters_zset-max-ziplist-entries, null)  : null
    zset-max-ziplist-value                        = each.value.engine == "Redis" ? try(each.value.parameters_zset-max-ziplist-value, null)    : null
    latency-monitor-threshold                     = each.value.engine == "Redis" ? try(each.value.parameters_latency-monitor-threshold, null) : null
    maxclients                                    = try(each.value.parameters_maxclients, null)
    notify-keyspace-events                        = each.value.engine == "Redis" ? try(each.value.parameters_notify-keyspace-events, null) : null
    repl-backlog-size                             = each.value.engine == "Redis" ? try(each.value.parameters_repl-backlog-size, null) : null
    repl-backlog-ttl                              = each.value.engine == "Redis" ? try(each.value.parameters_repl-backlog-ttl, null) : null
    appendfsync                                   = each.value.engine == "Redis" ? try(each.value.parameters_appendfsync, null) : null
    appendonly                                    = each.value.engine == "Redis" ? try(each.value.parameters_appendonly, null) : null
    slowlog-log-slower-than                       = each.value.engine == "Redis" ? try(each.value.parameters_slowlog-log-slower-than, null) : null
    slowlog-max-len                               = each.value.engine == "Redis" ? try(each.value.parameters_slowlog-max-len, null) : null
    lua-time-limit                                = each.value.engine == "Redis" ? try(each.value.parameters_lua-time-limit, null) : null
    repl-timeout                                  = each.value.engine == "Redis" ? try(each.value.parameters_repl-timeout, null) : null
    proto-max-bulk-len                            = each.value.engine == "Redis" ? try(each.value.parameters_proto-max-bulk-len, null) : null
    master-read-only                              = each.value.engine == "Redis" ? try(each.value.parameters_master-read-only, null) : null
    client-output-buffer-slave-soft-limit         = each.value.engine == "Redis" ? try(each.value.parameters_client-output-buffer-slave-soft-limit, null) : null
    client-output-buffer-slave-hard-limit         = each.value.engine == "Redis" ? try(each.value.parameters_client-output-buffer-slave-hard-limit, null) : null
    client-output-buffer-limit-slave-soft-seconds = each.value.engine == "Redis" ? try(each.value.parameters_client-output-buffer-limit-slave-soft-seconds, null) : null
    active-expire-num                             = each.value.engine == "Redis" ? try(each.value.parameters_active-expire-num, null) : null
    reserved-memory-percent                       = each.value.engine == "Memcached" ? try(each.value.parameters_reserved-memory-percent, null) : null
  }
}