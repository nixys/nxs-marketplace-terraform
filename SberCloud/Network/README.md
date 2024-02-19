# Network

## Introduction

This is a set of terraform modules for the SberCloud provider for building a network and creating any different network resources

## Modules

| Modules | Settings | Resources | Description |
| --- | ---  | --- | --- |
| `elb` |[elb](elb/README.md)| - sbercloud_elb_l7rule<br> - sbercloud_lb_l7rule<br> - sbercloud_elb_ipgroup<br> - sbercloud_lb_whitelist<br> - sbercloud_elb_monitor<br> - sbercloud_lb_monitor<br> - sbercloud_elb_pool<br> - sbercloud_lb_pool<br> - sbercloud_elb_member<br> - sbercloud_lb_member<br> - sbercloud_elb_loadbalancer<br> - sbercloud_lb_loadbalancer<br> - sbercloud_elb_listener<br> - sbercloud_lb_listener<br> - sbercloud_elb_l7policy<br> - sbercloud_lb_l7policy<br> - sbercloud_elb_certificate<br> - sbercloud_lb_certificate | ELB settings |
| `routes` |[routes](routes/README.md)| - sbercloud_vpc_route_table | Route table(s) settings |
| `vpc` |[vpc](vpc/README.md)| - sbercloud_vpc<br> - sbercloud_vpc_subnet<br> - sbercloud_vpc_peering_connection<br> - sbercloud_vpc_peering_connection_accepter<br> - sbercloud_vpc_eip<br> - sbercloud_networking_vip<br> - sbercloud_nat_gateway<br> - sbercloud_network_acl<br> - sbercloud_network_acl_rule<br> - sbercloud_networking_secgroup<br> - sbercloud_networking_secgroup_rule<br> - sbercloud_nat_snat_rule<br> - sbercloud_nat_dnat_rule | Network settings |
