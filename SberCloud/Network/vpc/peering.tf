resource "sbercloud_vpc_peering_connection" "peering" {
  for_each       = var.peering
  provider       = sbercloud.requester_provider
  name           = try(each.value.name, each.key)
  vpc_id         = try(each.value.vpc_id, sbercloud_vpc.vpc[each.value.vpc_name].id)
  region         = try(each.value.region, "ru-moscow-1")
  peer_vpc_id    = try(each.value.peer_vpc_id, sbercloud_vpc.vpc[each.value.peer_vpc_name].id)
  peer_tenant_id = try(each.value.peer_tenant_id, null)
}

resource "sbercloud_vpc_peering_connection_accepter" "accepter_peering" {
  for_each                  = var.peering_accepter
  provider                  = sbercloud.accepter_provider
  region                    = try(each.value.region, "ru-moscow-1")
  accept                    = try(each.value.accept, false)
  vpc_peering_connection_id = each.value.vpc_peering_connection_id
}
