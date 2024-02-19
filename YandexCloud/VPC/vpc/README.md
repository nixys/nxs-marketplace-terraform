# Virtual Private Cloud (VPC)

## Introduction

This is a set of terraform modules for the Yandex Cloud provider for building a network and creating network resources.

## Features

- Supported networks
- Supported subnets
- Supported gateways
- Supported routes
- Supported static ips/address
- Supported security groups

## Settings

| Option | Type | Required | Default value |Description |
| --- | ---  | --- | --- | --- |
| `networks.description` | String | No | "Created by Terraform" | An optional description of this resource. Provide this property when you create the resource. |
| `networks.labels` | Map | No | {} | Labels to apply to this network. A list of key/value pairs. |
| `subnets.description` | String | No | "Created by Terraform" | An optional description of the subnet. Provide this property when you create the resource. |
| `subnets.network_name` | String | Yes | - | The name of the network where the resource needs to be created. |
| `subnets.cidr` | List | Yes | - | A list of blocks of internal IPv4 addresses that are owned by this subnet. Provide this property when you create the subnet. For example, 10.0.0.0/22 or 192.168.0.0/16. Blocks of addresses must be unique and non-overlapping within a network. Minimum subnet size is /28, and maximum subnet size is /16. Only IPv4 is supported. |
| `subnets.zone` | String | Yes | - | Name of the Yandex.Cloud zone for this subnet. |
| `subnets.route_table_name` | String | No | null | Name of the route table where to create. |
| `subnets.labels` | Map | No | {} | Labels to assign to this subnet. A list of key/value pairs. |
| `gateways.description` | String | No | "Created by Terraform" | An optional description of this resource. Provide this property when you create the resource. |
| `gateways.labels` | Map | No | {} | Labels to apply to this VPC Gateway. A list of key/value pairs. |
| `routes.network_name` | String | Yes | - | The name of the network where the resource needs to be created. |
| `routes.description` | String | No | "Created by Terraform" | "Created by Terraform" |
| `routes.static_route` | List | Yes | - | A list of static route records for the route table. The structure is documented below. |
| `routes.labels` | Map | No | {} | Labels to assign to this route table. A list of key/value pairs. |
| `static_ips.description` | String | No | "Created by Terraform" | An optional description of this resource. Provide this property when you create the resource. |
| `static_ips.deletion_protection` | Bool | No | true | Flag that protects the address from accidental deletion. |
| `static_ips.external_ipv4_address` | List | Yes | - | Èlock describing the area where the address is located. |
| `static_ips.labels` | Map | {} | - | Labels to apply to this resource. A list of key/value pairs. |
| `security_groups.description` | String | No | "Created by Terraform" | Description of the security group. |
| `security_groups.network_name` | String | Yes | - | The name of the network where the resource needs to be created. |
| `security_groups.firewall_ingress_rules` | List | Yes | - | Block describing incoming security rules. |
| `security_groups.firewall_ingress_rules.protocol` | String | Yes | - | One of ANY, TCP, UDP, ICMP, IPV6_ICMP. |
| `security_groups.firewall_ingress_rules.description` | String | No | - | Description of the rule. |
| `security_groups.firewall_ingress_rules.labels` | Map | No | - | Labels to assign to this rule. |
| `security_groups.firewall_ingress_rules.from_port` | Int | No | - | Minimum port number. |
| `security_groups.firewall_ingress_rules.to_port` | Int | No | - | Maximum port number. |
| `security_groups.firewall_ingress_rules.port` | Int | No | - | Port number (if applied to a single port). |
| `security_groups.firewall_ingress_rules.predefined_target` | String | No | - | Special-purpose targets. self_security_group refers to this particular security group. loadbalancer_healthchecks represents loadbalancer health check nodes. |
| `security_groups.firewall_ingress_rules.v4_cidr_blocks` | List | No | - | The blocks of IPv4 addresses for this rule. |
| `security_groups.firewall_ingress_rules.v6_cidr_blocks` | List | No | - | The blocks of IPv6 addresses for this rule. v6_cidr_blocks argument is currently not supported. It will be available in the future. |
| `security_groups.firewall_egress_rules` | List | No | Allow ALL | Block describing outgoing security rules. |
| `security_groups.firewall_egress_rules.protocol` | String | Yes | - | One of ANY, TCP, UDP, ICMP, IPV6_ICMP. |
| `security_groups.firewall_egress_rules.description` | String | No | - | Description of the rule. |
| `security_groups.firewall_egress_rules.labels` | Map | No | - | Labels to assign to this rule. |
| `security_groups.firewall_egress_rules.from_port` | Int | No | - | Minimum port number. |
| `security_groups.firewall_egress_rules.to_port` | Int | No | - | Maximum port number. |
| `security_groups.firewall_egress_rules.port` | Int | No | - | Port number (if applied to a single port). |
| `security_groups.firewall_egress_rules.predefined_target` | String | No | - | Special-purpose targets. self_security_group refers to this particular security group. loadbalancer_healthchecks represents loadbalancer health check nodes. |
| `security_groups.firewall_egress_rules.v4_cidr_blocks` | List | No | - | The blocks of IPv4 addresses for this rule. |
| `security_groups.firewall_egress_rules.v6_cidr_blocks` | List | No | - | The blocks of IPv6 addresses for this rule. v6_cidr_blocks argument is currently not supported. It will be available in the future. |
| `security_groups.labels` | Map | No | {} | Labels to assign to this security group. |

## Example

Usage example located in this [directory](docs/example).
