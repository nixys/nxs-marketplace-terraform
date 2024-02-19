resource "yandex_lb_network_load_balancer" "loadbalancer" {
  for_each = var.load_balancers

  name                = each.key
  description         = try(each.value.description, "Created by Terraform")
  type                = try(each.value.type, "external")
  deletion_protection = try(each.value.deletion_protection, true)

  dynamic "listener" {
    for_each = each.value.listener
    content {
      name = listener.value.name
      port = listener.value.port
      target_port = try(listener.value.target_port, listener.value.port)
      dynamic "external_address_spec" {
        for_each = each.value.type == "external" ? listener.value.external_address_spec : []
        content {
          ip_version = try(external_address_spec.value.ip_version, "ipv4")
          address    = try(external_address_spec.value.address, null)
        }
      }
      dynamic "internal_address_spec" {
        for_each = each.value.type == "external" ? [] : listener.value.internal_address_spec
        content {
          ip_version = try(internal_address_spec.value.ip_version, "ipv4")
          address    = try(internal_address_spec.value.address, null)
          subnet_id  = internal_address_spec.value.subnet_id
        }
      }
    }
  }

  dynamic "attached_target_group" {
    for_each = each.value.attached_target_group
    content {
      target_group_id = yandex_lb_target_group.target_group[attached_target_group.value.target_name].id
      dynamic "healthcheck" {
        for_each = attached_target_group.value.healthcheck
        content {
          name                = try(healthcheck.value.name, "https")
          interval            = try(healthcheck.value.interval, 2)
          timeout             = try(healthcheck.value.timeout, 1)
          unhealthy_threshold = try(healthcheck.value.unhealthy_threshold, 2)
          healthy_threshold   = try(healthcheck.value.healthy_threshold, 3)
          dynamic "http_options" {
            for_each = try(healthcheck.value.http_options, [])
            content {
              port = http_options.value.port
              path = http_options.value.path
            }
          }
          dynamic "tcp_options" {
            for_each = try(healthcheck.value.tcp_options, [])
            content {
              port = tcp_options.value.port
            }
          }
        }
      }
    }
  }

  labels = try(each.value.labels, {})

  depends_on = [yandex_lb_target_group.target_group]
}