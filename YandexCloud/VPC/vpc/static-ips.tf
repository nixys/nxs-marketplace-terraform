resource "yandex_vpc_address" "address" {
  for_each = var.static_ips

  name                = each.key
  description         = try(each.value.description, "Created by Terraform")
  deletion_protection = try(each.value.deletion_protection, true)

  external_ipv4_address {
    zone_id                  = each.value.zone
    ddos_protection_provider = each.value.outgoing_smtp_capability == "" ? each.value.ddos_protection_provider : null
    outgoing_smtp_capability = each.value.ddos_protection_provider == "" ? each.value.outgoing_smtp_capability : null
  }
  labels         = try(each.value.labels, {})
}
