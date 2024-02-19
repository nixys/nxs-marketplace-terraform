# Network-load-balancer

## Introduction

This is a set of terraform modules for the Yandex Cloud provider for building a network load balancer and creating any different load balancer resources

## Features

- Supported Network Load Balancer
- Supported target groups

## Settings

| Option | Type | Required | Default value |Description |
| --- | ---  | --- | --- | --- |
| `target_groups.description` | String | No | "Created by Terraform" | An optional description of the target group. Provide this property when you create the resource. |
| `target_groups.target` | List | Yes | - | An optional description of this resource. Provide this property when you create the resource. |
| `target_groups.target.subnet_id` | String | Yes | - | ID of the subnet that targets are connected to. All targets in the target group must be connected to the same subnet within a single availability zone. |
| `target_groups.target.address` | String | Yes | - | IP address of the target. |
| `target_groups.labels` | Map| No| {} | Labels to assign to this target group. A list of key/value pairs. |
| `load_balancers.description` | String | No | "Created by Terraform" | An optional description of the network load balancer. Provide this property when you create the resource. |
| `load_balancers.type` | String | No | "external" | Type of the network load balancer. Must be one of 'external' or 'internal'. The default is 'external'. |
| `load_balancers.deletion_protection` | Bool | No | true | Flag that protects the network load balancer from accidental deletion. |
| `load_balancers.listener` | List | No | "Created by Terraform" | An optional description of this resource. Provide this property when you create the resource. |
| `load_balancers.listener.name` | String | Yes | - | Name of the listener. The name must be unique for each listener on a single load balancer. |
| `load_balancers.listener.port` | Int | Yes | - | Port for incoming traffic. |
| `load_balancers.listener.external_address_spec` | List | Yes | - | A block with a description of the balancer's external listener. |
| `load_balancers.listener.internal_address_spec` | List | Yes | - | A block with a description of the balancer's internal listener. |
| `load_balancers.attached_target_group` | List | Yes | - | Block with description of attached_target_group. |
| `load_balancers.attached_target_group.target_name` | String | Yes | - | An optional description of this resource. Provide this property when you create the resource. |
| `load_balancers.attached_target_group.healthcheck` | List | Yes | - | Block with description of healthcheck. |
| `load_balancers.attached_target_group.healthcheck.name` | String | Yes | "https" | Name of the health check. The name must be unique for each target group that attached to a single load balancer. |
| `load_balancers.attached_target_group.healthcheck.interval` | Int | No | 2 | The interval between health checks. The default is 2 seconds. |
| `load_balancers.attached_target_group.healthcheck.timeout` | Int | No | 1 | Timeout for a target to return a response for the health check. The default is 1 second. |
| `load_balancers.attached_target_group.healthcheck.unhealthy_threshold` | Int | No | 2 | Number of failed health checks before changing the status to UNHEALTHY. |
| `load_balancers.attached_target_group.healthcheck.healthy_threshold` | Int | No | 3 | Number of successful health checks required in order to set the HEALTHY status for the target. |
| `load_balancers.attached_target_group.healthcheck.http_options` | List | No | - | HTTP block with verification description. |
| `load_balancers.attached_target_group.healthcheck.tcp_options` | List | No | - | TCP block with verification description. |
| `load_balancers.labels` | Map | No | {} | Labels to assign to this network load balancer. A list of key/value pairs. |

## Example

Usage example located in this [directory](docs/example).
