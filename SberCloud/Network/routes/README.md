# routes (routes)

## Introduction

This is a set of terraform modules for the SberCloud provider for building a network and creating network resources.

## Features

- Supported routes

## Settings

| Option | Type | Required | Default value |Description |
| --- | ---  | --- | --- | --- |
| `route_tables.name` | String | Yes | - | **You can specify your own value for the name parameter. If you do not specify it, then the name will be the key of the element in the map.** Specifies the route table name. The value is a string of no more than 64 characters that can contain letters, digits, underscores (_), hyphens (-), and periods (.). |
| `route_tables.vpc_id` | String | Yes | - | Specifies the VPC ID for which a route table is to be added. Changing this creates a new resource. |
| `route_tables.region` | String | No | "ru-moscow-1" | The region in which to create the vpc route table. If omitted, the provider-level region will be used. Changing this creates a new resource. |
| `route_tables.description` | String | No | "Created by Terraform" | Specifies the supplementary information about the route table. The value is a string of no more than 255 characters and cannot contain angle brackets (< or >). |
| `route_tables.subnets` | List | No | null | Specifies an array of one or more subnets associating with the route table. The custom route table associated with a subnet affects only the outbound traffic. The default route table determines the inbound traffic. |
| `route_tables.route` | List | No | null | Specifies an array of one or more subnets associating with the route table. The custom route table associated with a subnet affects only the outbound traffic. The default route table determines the inbound traffic. |
| `route_tables.destination` | String | Yes | - | Specifies the destination address in the CIDR notation format, for example, 192.168.200.0/24. The destination of each route must be unique and cannot overlap with any subnet in the VPC. |
| `route_tables.type` | String | Yes | - | Specifies the route type. Currently, the value can be: ecs, eni, vip, nat, peering, vpn, dc and cc. |
| `route_tables.nexthop` | String | No | - | Specifies the next hop.<br> - If the route type is ecs, the value is an ECS instance ID in the VPC.<br> - If the route type is eni, the value is the extension NIC of an ECS in the VPC.<br> - If the route type is vip, the value is a virtual IP address.<br> - If the route type is nat, the value is a VPN gateway ID.<br> - If the route type is peering, the value is a VPC peering connection ID.<br> - If the route type is vpn, the value is a VPN gateway ID.<br> - If the route type is dc, the value is a Direct Connect gateway ID.<br> - If the route type is cc, the value is a Cloud Connection ID. |
| `route_tables.description` | String | No | "Created by Terraform" | Specifies the supplementary information about the route. The value is a string of no more than 255 characters and cannot contain angle brackets (< or >). |
| `route_tables.route_table_names` | List of route table names. |
| `route_tables.route_table_ids` | A map that shows the IDs of created route tables |

## Example

Usage example located in this [directory](docs/example).
