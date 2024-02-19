# Virtual Private Cloud (VPC)

## Introduction

This is a set of terraform modules for the SberCloud provider for building a network and creating network resources.

## Features

- Supported VPC
- Supported subnets
- Supported nat, snat, dnat
- Supported nacl, security groups and security group rules
- Supported peering, routes, EIP and virtual IP

## Settings

| Option | Type | Required | Default value |Description |
| --- | ---  | --- | --- | --- |
| `general_project_id` | String | No | `null` | Default project for all module |
| `vpc.name` | String | Yes | - | **You can specify your own value for the name parameter. If you do not specify it, then the name will be the key of the element in the map.** Specifies the name of the VPC. The name must be unique for a tenant. The value is a string of no more than 64 characters and can contain digits, letters, underscores (_), and hyphens (-). |
| `vpc.cidr` | String | Yes | - | Specifies the range of available subnets in the VPC. The value ranges from 10.0.0.0/8 to 10.255.255.0/24, 172.16.0.0/12 to 172.31.255.0/24, or 192.168.0.0/16 to 192.168.255.0/24. |
| `vpc.region` | String | No | "ru-moscow-1" | Specifies the region in which to create the VPC. If omitted, the provider-level region will be used. Changing this creates a new VPC resource. |
| `vpc.description` | String | No | "Created by Terraform" | Specifies supplementary information about the VPC. The value is a string of no more than 255 characters and cannot contain angle brackets (< or >). |
| `vpc.project_id` | String | No | var.general_project_id | Specifies the enterprise project id of the VPC. Changing this creates a new VPC resource. |
| `vpc.tags` | Map | No | {created_by = "Terraform"} | Specifies the key/value pairs to associate with the VPC. |
| `subnets.name` | String | Yes | - | **You can specify your own value for the name parameter. If you do not specify it, then the name will be the key of the element in the map.** Specifies the subnet name. The value is a string of 1 to 64 characters that can contain letters, digits, underscores (_), and hyphens (-). |
| `subnets.cidr` | String | Yes | - | Specifies the network segment on which the subnet resides. The value must be in CIDR format and within the CIDR block of the VPC. The subnet mask cannot be greater than 28. Changing this creates a new Subnet. |
| `subnets.gateway_ip` | String | Yes | - | Specifies the gateway of the subnet. The value must be a valid IP address in the subnet segment. Changing this creates a new Subnet. |
| `subnets.vpc_name` | String | No | - | Specifies the name of the VPC to which the subnet belongs. Changing this creates a new Subnet. Used only if the resource is created in the same module where the VPC was created. |
| `subnets.vpc_id` | String | Yes | - | Specifies the ID of the VPC to which the subnet belongs. Changing this creates a new Subnet. If vpc_name is specified, the vpc_id parameter is optional |
| `subnets.ipv6_enable` | Bool | No | false | Specifies whether the IPv6 function is enabled for the subnet. Defaults to false. |
| `subnets.dhcp_enable` | Bool | No | true | Specifies whether the DHCP function is enabled for the subnet. Defaults to true. |
| `subnets.dns_list` | List | No | null | Specifies the DNS server address list of a subnet. This field is required if you need to use more than two DNS servers. This parameter value is the superset of both DNS server address 1 and DNS server address 2. |
| `subnets.primary_dns` | String | No | null | Specifies the IP address of DNS server 1 on the subnet. The value must be a valid IP address. |
| `subnets.secondary_dns` | String | No | null | Specifies the IP address of DNS server 2 on the subnet. The value must be a valid IP address. |
| `subnets.region` | String | No | "ru-moscow-1" | Specifies tThe region in which to create the vpc subnet. If omitted, the provider-level region will be used. Changing this creates a new Subnet. |
| `subnets.availability_zone` | String | No | null | Specifies the availability zone (AZ) to which the subnet belongs. The value must be an existing AZ in the system. Changing this creates a new Subnet. |
| `subnets.description` | String | No | "Created by Terraform" | Specifies supplementary information about the subnet. The value is a string of no more than 255 characters and cannot contain angle brackets (< or >). |
| `subnets.tags` | Map | No | {created_by = "Terraform"} | The key/value pairs to associate with the subnet. |
| `peering.name` | String | Yes | - | **You can specify your own value for the name parameter. If you do not specify it, then the name will be the key of the element in the map.** Specifies the name of the VPC peering connection. The value can contain 1 to 64 characters. |
| `peering.vpc_name` | String | No | - | Specifies the name of a VPC involved in a VPC peering connection. Changing this creates a new VPC peering connection. Used only if the resource is created in the same module where the VPC was created. |
| `peering.vpc_id` | String | Yes | - | Specifies the ID of a VPC involved in a VPC peering connection. Changing this creates a new VPC peering connection. If vpc_name is specified, the vpc_id parameter is optional. |
| `peering.peer_vpc_name` | String | No | - | Specifies the VPC name of the accepter tenant. Changing this creates a new VPC peering connection. Used only if the resource is created in the same module where the VPC was created |
| `peering.peer_vpc_id` | String | Yes | - | Specifies the VPC ID of the accepter tenant. Changing this creates a new VPC peering connection. If peer_vpc_name is specified, the peer_vpc_id parameter is optional.|
| `peering.region` | String | No | "ru-moscow-1" | The region in which to create the VPC peering connection. If omitted, the provider-level region will be used. Changing this creates a new VPC peering connection resource. |
| `peering.peer_tenant_id` | String | No | null | Specified the Tenant Id of the accepter tenant. Changing this creates a new VPC peering connection. |
| `peering_accepter.vpc_peering_connection_id` | String | Yes | - | The VPC Peering Connection ID to manage. Changing this creates a new VPC peering connection accepter. |
| `peering_accepter.accept` | Bool | No | - | Whether or not to accept the peering request. Defaults to false. |
| `peering_accepter.region` | String | No | "ru-moscow-1" | The region in which to create the vpc peering connection accepter. If omitted, the provider-level region will be used. Changing this creates a new VPC peering connection accepter resource. |
| `eips.type` | String | No | "5_bgp" | The type of the eip. Changing this creates a new eip. |
| `eips.ip_address` | String | No | null | The value must be a valid IP address in the available IP address segment. Changing this creates a new eip. |
| `eips.port_id` | String | No | null | The port id which this eip will associate with. If the value is "" or this not specified, the eip will be in unbind state. |
| `eips.share_type` | String | No | "PER" | Whether the bandwidth is dedicated or shared. Changing this creates a new eip. Possible values are as follows:<br> - PER: Dedicated bandwidth<br> - WHOLE: Shared bandwidth |
| `eips.bandwidth_name` | String | Yes | - | The bandwidth name, which is a string of 1 to 64 characters that contain letters, digits, underscores (_), and hyphens (-). This parameter is mandatory when share_type is set to PER. |
| `eips.bandwidth_size` | String | Yes | - | The bandwidth size. The value ranges from 1 to 300 Mbit/s. This parameter is mandatory when share_type is set to PER. |
| `eips.bandwidth_id` | String | No | - | The shared bandwidth id. This parameter is mandatory when share_type is set to WHOLE. Changing this creates a new eip. |
| `eips.charge_mode` | String | No | "bandwidth" | Specifies whether the bandwidth is billed by traffic or by bandwidth size. The value can be traffic or bandwidth. Changing this creates a new eip. |
| `eips.auto_renew` | Bool | No | true | Specifies whether auto renew is enabled. Valid values are "true" and " false". Changing this creates a new resource. |
| `eips.region` | String | No | "ru-moscow-1" | The region in which to create the eip resource. If omitted, the provider-level region will be used. Changing this creates a new eip resource. |
| `eips.project_id` | String | No | var.general_project_id | The enterprise project id of the elastic IP. Changing this creates a new eip. |
| `eips.tags` | Map | No | {created_by = "Terraform"} | Specifies the key/value pairs to associate with the elastic IP. |
| `virtual_ips.name` | String | Yes | - | **You can specify your own value for the name parameter. If you do not specify it, then the name will be the key of the element in the map.** Specifies a unique name for the VIP. |
| `virtual_ips.network_name` | String | No | - | Specifies the network name of the VPC subnet to which the VIP belongs. Changing this will create a new VIP resource. Used only if the resource is created in the same module where the subnet was created. |
| `virtual_ips.network_id` | String | Yes | - | Specifies the network ID of the VPC subnet to which the VIP belongs. Changing this will create a new VIP resource. If network_name is specified, the network_id parameter is optional.|
| `virtual_ips.ip_version` | Int | No | "4" | Specifies the IP version, either 4 (default) or 6. Changing this will create a new VIP resource. |
| `virtual_ips.ip_address` | String | No | null | Specifies the IP address desired in the subnet for this VIP. Changing this will create a new VIP resource. |
| `virtual_ips.region` | String | No | "ru-moscow-1" | Specifies the region in which to create the VIP. If omitted, the provider-level region will be used. Changing this will create a new VIP resource. |
| `nat_gateway.name` | String | Yes | - | **You can specify your own value for the name parameter. If you do not specify it, then the name will be the key of the element in the map.** Specifies the nat gateway name. The name can contain only digits, letters, underscores (_), and hyphens(-). |
| `nat_gateway.vpc_name` | String | No | - | Specifies the name of the VPC to which the NAT gateway belongs. Changing this will create a new resource. |
| `nat_gateway.vpc_id` | String | Yes | - | Specifies the ID of the VPC to which the NAT gateway belongs. Changing this will create a new resource. If vpc_name is specified, the vpc_id parameter is optional. |
| `nat_gateway.subnet_name` | String | No | - | Specifies the subnet name of the downstream interface (the next hop of the DVR) of the NAT gateway. Changing this will create a new resource. Used only if the resource is created in the same module where the subnet was created |
| `nat_gateway.subnet_id` | String | Yes | - | Specifies the subnet ID of the downstream interface (the next hop of the DVR) of the NAT gateway. Changing this will create a new resource. If subnet_name is specified, the subnet_id parameter is optional. |
| `nat_gateway.spec` | String | Yes | - | Specifies the nat gateway type. The value can be:<br> - 1: small type, which supports up to 10,000 SNAT connections.<br> - 2: medium type, which supports up to 50,000 SNAT connections.<br> - 3: large type, which supports up to 200,000 SNAT connections.<br> - 4: extra-large type, which supports up to 1,000,000 SNAT connections. |
| `nat_gateway.region` | String | No | "ru-moscow-1" | Specifies the region in which to create the Nat gateway resource. If omitted, the provider-level region will be used. Changing this creates a new nat gateway. |
| `nat_gateway.description` | String | No | "Created by Terraform" | Specifies the description of the nat gateway. The value contains 0 to 255 characters, and angle brackets (<) and (>) are not allowed. |
| `nat_gateway.project_id` | String | No | var.general_project_id | Specifies the enterprise project id of the nat gateway. The value can contains maximum of 36 characters which it is string "0" or in UUID format with hyphens (-). Changing this creates a new nat gateway. |
| `nat_gateway.tags` | Map | No | {created_by = "Terraform"} | Specifies the key/value pairs to associate with the NAT geteway. |
| `snat.nat_gateway_name` | String | No | - | Name of the nat gateway this snat rule belongs to. Changing this creates a new snat rule. Used only if the resource is created in the same module where the nat gateway was created. |
| `snat.nat_gateway_id` | String | Yes | - | ID of the nat gateway this snat rule belongs to. Changing this creates a new snat rule. If nat_gateway_name is specified, the nat_gateway_id parameter is optional. |
| `snat.floating_ip_name` | String | No | - | Name of the floating ip this snat rule connets to. Changing this creates a new snat rule. Used only if the resource is created in the same module where the IP address was created. |
| `snat.floating_ip_id` | String | Yes | - | ID of the floating ip this snat rule connets to. Changing this creates a new snat rule. If floating_ip_name is specified, the floating_ip_id parameter is optional. |
| `snat.subnet_id` | String | No | null | Specifies the network names of subnet connected by SNAT rule (VPC side). This parameter and cidr are alternative. Changing this will create a new resource. |
| `snat.subnet_id` | String | No | null | Specifies the network IDs of subnet connected by SNAT rule (VPC side). This parameter and cidr are alternative. Changing this will create a new resource. |
| `snat.cidr` | String | No | null | Specifies CIDR, which can be in the format of a network segment or a host IP address. This parameter and network_id are alternative. Changing this creates a new snat rule. |
| `snat.source_type` | Int | No | "0" | Specifies the scenario. The valid value is 0 (VPC scenario) and 1 (Direct Connect scenario). Defaults to 0, only cidr can be specified over a Direct Connect connection. Changing this creates a new snat rule. |
| `snat.region` | String | No | "ru-moscow-1" | The region in which to create the snat rule resource. If omitted, the provider-level region will be used. Changing this creates a new snat rule resource. |
| `snat.description` | String | No | "Created by Terraform" | Specifies the description of the SNAT rule. The value is a string of no more than 255 characters, and angle brackets (<>) are not allowed. |
| `dnat.nat_gateway_name` | String | No | - | Name of the nat gateway this dnat rule belongs to. Changing this creates a new dnat rule. Used only if the resource is created in the same module where the nat gateway was created |
| `dnat.nat_gateway_id` | String | Yes | - | ID of the nat gateway this dnat rule belongs to. Changing this creates a new dnat rule. If nat_gateway_name is specified, the nat_gateway_id parameter is optional. |
| `dnat.floating_ip_name` | String | No | - | Specifies the name of the floating IP address. Changing this creates a new resource. Used only if the resource is created in the same module where the IP address was created |
| `dnat.floating_ip_id` | String | Yes | - | Specifies the ID of the floating IP address. Changing this creates a new resource. If floating_ip_name is specified, the floating_ip_id parameter is optional. |
| `dnat.internal_service_port` | Int | Yes | - | Specifies port used by ECSs or BMSs to provide services for external systems. Changing this creates a new resource. |
| `dnat.external_service_port` | int | Yes | - | Specifies port used by ECSs or BMSs to provide services for external systems. Changing this creates a new dnat rule. |
| `dnat.protocol` | String | No | "ANY" | Specifies the protocol type. Currently, TCP, UDP, and ANY are supported. Changing this creates a new dnat rule. |
| `dnat.port_id` | String | Int | null | Specifies the port ID of an ECS or a BMS. This parameter and private_ip are alternative. Changing this creates a new dnat rule. |
| `dnat.private_ip` | String | Int | null | Specifies the private IP address of a user, for example, the IP address of a VPC for dedicated connection. This parameter and port_id are alternative. Changing this creates a new dnat rule. |
| `dnat.internal_service_port_range` | String | Int | "0" | Specifies port range used by Floating IP provide services for external systems. This parameter and external_service_port_range are mapped 1:1 in sequence (ranges must have the same length). The valid value for range is 1-65535 and the port ranges can only be concatenated with the - character. |
| `dnat.external_service_port_range` | String | Int | "0" | Specifies port range used by ECSs or BMSs to provide services for external systems. This parameter and internal_service_port_range are mapped 1:1 in sequence (ranges must have the same length). The valid value for range is 1-65535 and the port ranges can only be concatenated with the - character. Required if internal_service_port_range is set. |
| `dnat.region` | String | No | "ru-moscow-1" | The region in which to create the snat rule resource. If omitted, the provider-level region will be used. Changing this creates a new snat rule resource. |
| `dnat.description` | String | No | "Created by Terraform" | Specifies the description of the SNAT rule. The value is a string of no more than 255 characters, and angle brackets (<>) are not allowed. |
| `network_acl.name` | String | Yes | - | **You can specify your own value for the name parameter. If you do not specify it, then the name will be the key of the element in the map.** Specifies the network ACL name. This parameter can contain a maximum of 64 characters, which may consist of letters, digits, underscores (_), and hyphens (-). |
| `network_acl.region` | String | No | "ru-moscow-1" | Specifies the region in which to create the Nat gateway resource. If omitted, the provider-level region will be used. Changing this creates a new nat gateway. |
| `network_acl.description` | String | No | "Created by Terraform" | Specifies the description of the nat gateway. The value contains 0 to 255 characters, and angle brackets (<) and (>) are not allowed. |
| `network_acl.subnet_names` | List | No | null | A list of the names of networks associated with the network ACL. Used only if the resource is created in the same module where the subnets was created. |
| `network_acl.subnets` | List | No | null | A list of the IDs of networks associated with the network ACL. |
| `network_acl.inbound_rules` | Map | No | null | The presence of a value for this parameter causes the creation of the sbercloud_network_acl_rule resource. Specifies a map of one or more rules associating with the network ACL. The custom ingress rules associated with a network ACL affects only the inbound traffic. The inbound_rules object is documented below. |
| `network_acl.outbound_rules` | Map | No | null | The presence of a value for this parameter causes the creation of the sbercloud_network_acl_rule resource. Specifies a map of one or more rules associating with the network ACL. The custom ingress rules associated with a network ACL affects only the outbound traffic. The outbound_rules object is documented below. |
| `outbound_rules.name` | String | Yes | - | **You can specify your own value for the name parameter. If you do not specify it, then the name will be the key of the element in the map.**. Specifies a unique name for the network ACL rule. |
| `outbound_rules.protocol` | String | Yes | "tcp" | Specifies the protocol supported by the network ACL rule. Valid values are: tcp (default), udp, icmp and any. |
| `outbound_rules.action` | String | No | "allow" | Specifies the action in the network ACL rule. Currently, the value can be allow (default) or deny. |
| `outbound_rules.ip_version` | Int | No | "4" | Specifies the IP version, either 4 (default) or 6. This parameter is available after the IPv6 function is enabled. |
| `outbound_rules.source_ip_address` | String | No | null | Specifies the source IP address that the traffic is allowed from. The default value is 0.0.0.0/0. For example: xxx.xxx.xxx.xxx (IP address), xxx.xxx.xxx.0/24 (CIDR block). |
| `outbound_rules.destination_ip_address` | String | No | null | Specifies the destination IP address to which the traffic is allowed. The default value is 0.0.0.0/0. For example: xxx.xxx.xxx.xxx (IP address), xxx.xxx.xxx.0/24 (CIDR block). |
| `outbound_rules.source_port` | String | No | null | Specifies the source port number or port number range. The value ranges from 1 to 65535. For a port number range, enter two port numbers connected by a colon(:). For example, 1:100. |
| `outbound_rules.destination_port` | String | No | null | Specifies the destination port number or port number range. The value ranges from 1 to 65535. For a port number range, enter two port numbers connected by a colon(:). For example, 1:100. |
| `outbound_rules.enabled` | Bool | No | true | Enabled status for the network ACL rule. Defaults to true. |
| `outbound_rules.region` | String | No | "ru-moscow-1" | The region in which to create the network ACL rule resource. If omitted, the provider-level region will be used. Changing this creates a new network ACL rule resource. |
| `outbound_rules.description` | String | No | "Created by Terraform" | Specifies the description for the network ACL rule. |
| `inbound_rules.name` | String | Yes | - | **You can specify your own value for the name parameter. If you do not specify it, then the name will be the key of the element in the map.**. Specifies a unique name for the network ACL rule. |
| `inbound_rules.protocol` | String | Yes | "tcp" | Specifies the protocol supported by the network ACL rule. Valid values are: tcp (default), udp, icmp and any. |
| `inbound_rules.action` | String | No | "allow" | Specifies the action in the network ACL rule. Currently, the value can be allow (default) or deny. |
| `inbound_rules.ip_version` | Int | No | "4" | Specifies the IP version, either 4 (default) or 6. This parameter is available after the IPv6 function is enabled. |
| `inbound_rules.source_ip_address` | String | No | null | Specifies the source IP address that the traffic is allowed from. The default value is 0.0.0.0/0. For example: xxx.xxx.xxx.xxx (IP address), xxx.xxx.xxx.0/24 (CIDR block). |
| `inbound_rules.destination_ip_address` | String | No | null | Specifies the destination IP address to which the traffic is allowed. The default value is 0.0.0.0/0. For example: xxx.xxx.xxx.xxx (IP address), xxx.xxx.xxx.0/24 (CIDR block). |
| `inbound_rules.source_port` | String | No | null | Specifies the source port number or port number range. The value ranges from 1 to 65535. For a port number range, enter two port numbers connected by a colon(:). For example, 1:100. |
| `inbound_rules.destination_port` | String | No | null | Specifies the destination port number or port number range. The value ranges from 1 to 65535. For a port number range, enter two port numbers connected by a colon(:). For example, 1:100. |
| `inbound_rules.enabled` | Bool | No | true | Enabled status for the network ACL rule. Defaults to true. |
| `inbound_rules.region` | String | No | "ru-moscow-1" | The region in which to create the network ACL rule resource. If omitted, the provider-level region will be used. Changing this creates a new network ACL rule resource. |
| `inbound_rules.description` | String | No | "Created by Terraform" | Specifies the description for the network ACL rule. |
| `security_groups.name` | String | Yes | - | **You can specify your own value for the name parameter. If you do not specify it, then the name will be the key of the element in the map.** A unique name for the security group. |
| `security_groups.delete_default_rules` | Bool | No | true | Whether or not to delete the default egress security rules. This is true by default. |
| `security_groups.region` | String | No | "ru-moscow-1" | The region in which to obtain the V2 networking client. A networking client is needed to create a port. If omitted, the region argument of the provider is used. Changing this creates a new security group. |
| `security_groups.description` | String | No | "Created by Terraform" | Description of the security group. |
| `security_groups.project_id` | String | No | var.general_project_id | Specifies the enterprise project id of the security group. Changing this creates a new security group. |
| `security_groups.ingress_rules` | Map | No | null | The presence of a value for this parameter causes the creation of the sbercloud_networking_secgroup_rule resource. Specifies a map of one or more inbound rules associating with the security group. The ingress_rules object is documented below. |
| `security_groups.egress_rules` | Map | No | null | The presence of a value for this parameter causes the creation of the sbercloud_networking_secgroup_rule resource. Specifies a map of one or more outbound rules associating with the security group. The egress_rules object is documented below. |
| `egress_rules.ethertype` | String | No | "IPv4" | The layer 3 protocol type, valid values are IPv4 or IPv6. Changing this creates a new security group rule. |
| `egress_rules.protocol` | String | No | null | Specifies the layer 4 protocol type, valid values are tcp, udp, icmp and icmpv6. If omitted, the protocol means that all protocols are supported. This is required if you want to specify a port range. Changing this creates a new security group rule. If the port and protocol values are not specified. The rule will be created for all protocols and ports. |
| `egress_rules.port_range_min` | Int | No | null | Specifies the lower part of the allowed port range, valid integer value needs to be between 1 and 65,535. Changing this creates a new security group rule. This parameter and ports are alternative. |
| `egress_rules.port_range_max` | Int | No | null | Specifies the higher part of the allowed port range, valid integer value needs to be between 1 and 65,535. Changing this creates a new security group rule. This parameter and ports are alternative. |
| `egress_rules.ports` | String | No | null | Specifies the allowed port value range, which supports single port (80), continuous port (1-30) and discontinous port (22, 3389, 80) The valid port values is range form 1 to 65,535. Changing this creates a new security group rule. If the port and protocol values are not specified. The rule will be created for all protocols and ports |
| `egress_rules.remote_ip_prefix` | String | No | null | Specifies the remote CIDR, the value needs to be a valid CIDR (i.e. 192.168.0.0/16). Changing this creates a new security group rule. |
| `egress_rules.remote_group_id` | String | No | null | Specifies the remote group ID. Changing this creates a new security group rule. |
| `egress_rules.remote_address_group_id` | String | No | null | Specifies the remote address group ID. This parameter is not used with port_range_min and port_range_max. Changing this creates a new security group rule. |
| `egress_rules.action` | String | No | "allow" | Specifies the effective policy. The valid values are allow and deny. This parameter is not used with port_range_min and port_range_max. Changing this creates a new security group rule. |
| `egress_rules.priority` | Int | No | "1" | Specifies the priority number. The valid value is range from 1 to 100. The default value is 1. This parameter is not used with port_range_min and port_range_max. Changing this creates a new security group rule. |
| `egress_rules.region` | String | No | "ru-moscow-1" | The region in which to obtain the V2 networking client. A networking client is needed to create a port. If omitted, the region argument of the provider is used. Changing this creates a new security group rule. |
| `egress_rules.description` | String | No | "Created by Terraform" |  Specifies the supplementary information about the networking security group rule. This parameter can contain a maximum of 255 characters and cannot contain angle brackets (< or >). Changing this creates a new security group rule. |
| `ingress_rules.ethertype` | String | No | "IPv4" | The layer 3 protocol type, valid values are IPv4 or IPv6. Changing this creates a new security group rule. |
| `ingress_rules.protocol` | String | No | null | Specifies the layer 4 protocol type, valid values are tcp, udp, icmp and icmpv6. If omitted, the protocol means that all protocols are supported. This is required if you want to specify a port range. Changing this creates a new security group rule. If the port and protocol values are not specified. The rule will be created for all protocols and ports. |
| `ingress_rules.port_range_min` | Int | No | null | Specifies the lower part of the allowed port range, valid integer value needs to be between 1 and 65,535. Changing this creates a new security group rule. This parameter and ports are alternative. |
| `ingress_rules.port_range_max` | Int | No | null | Specifies the higher part of the allowed port range, valid integer value needs to be between 1 and 65,535. Changing this creates a new security group rule. This parameter and ports are alternative. |
| `ingress_rules.ports` | String | No | null | Specifies the allowed port value range, which supports single port (80), continuous port (1-30) and discontinous port (22, 3389, 80) The valid port values is range form 1 to 65,535. Changing this creates a new security group rule. If the port and protocol values are not specified. The rule will be created for all protocols and ports |
| `ingress_rules.remote_ip_prefix` | String | No | null | Specifies the remote CIDR, the value needs to be a valid CIDR (i.e. 192.168.0.0/16). Changing this creates a new security group rule. |
| `ingress_rules.remote_group_id` | String | No | null | Specifies the remote group ID. Changing this creates a new security group rule. |
| `ingress_rules.remote_address_group_id` | String | No | null | Specifies the remote address group ID. This parameter is not used with port_range_min and port_range_max. Changing this creates a new security group rule. |
| `ingress_rules.action` | String | No | "allow" | Specifies the effective policy. The valid values are allow and deny. This parameter is not used with port_range_min and port_range_max. Changing this creates a new security group rule. |
| `ingress_rules.priority` | Int | No | "1" | Specifies the priority number. The valid value is range from 1 to 100. The default value is 1. This parameter is not used with port_range_min and port_range_max. Changing this creates a new security group rule. |
| `ingress_rules.region` | String | No | "ru-moscow-1" | The region in which to obtain the V2 networking client. A networking client is needed to create a port. If omitted, the region argument of the provider is used. Changing this creates a new security group rule. |
| `ingress_rules.description` | String | No | "Created by Terraform" |  Specifies the supplementary information about the networking security group rule. This parameter can contain a maximum of 255 characters and cannot contain angle brackets (< or >). Changing this creates a new security group rule. |

## Example

Usage example located in this [directory](docs/example).
