variable "general_project_id" {
  description = "Default project"
  type        = string
  default     = null
}

variable "vpc" {
  description = "VPC(s) settings"
  type = any
  default = {}
}

variable "subnets" {
  description = "Subnet(s) settings"
  type = any
  default = {}

  validation {
    condition     = can(index(var.subnets, "zone")) ? alltrue([for j in var.subnets : can(index(["ru-moscow-1a", "ru-moscow-1b", "ru-moscow-1c", "ru-moscow-1e"], index(j, "zone")))]) : true
    error_message = "Only ru-moscow-1a, ru-moscow-1b, ru-moscow-1c zones supported!"
  }

  validation {
    condition = alltrue([for j in var.subnets : length(try(regex("^10\\.|172\\.(1[6-9]|2(0-9)|3[0-1])\\.*|192\\.168\\.*", try(cidrhost(j.cidr, 0), false)), "")) > 0 ? true : false])

    error_message = "Only 10.0.0.0/8, 172.16.0.0/12, 192.168.0.0/16  cidr supported!"
  }

  validation {
    condition     = alltrue([for j in var.subnets : tonumber(split("/", j.cidr)[1]) >= 16 && tonumber(split("/", j.cidr)[1]) <= 28 ? true : false])
    error_message = "The maximum CIDR size in these ranges is /16, the minimum is /28!"
  }

  validation {
    condition     = alltrue([for j in var.subnets : can(cidrnetmask("${j.gateway_ip}/32"))])
    error_message = "Must be a valid IPv4 CIDR block address!"
  }
}

variable "peering" {
  description = "peering connection(s) settings"
  type    = any
  default = {}
}

variable "peering_accepter" {
  description = "peering connection accepter(s) settings"
  type    = any
  default = {}
}

variable "route_tables" {
  description = "Route tables settings"
  type        = any
  default = {}

  validation {
    condition     = alltrue([for j in var.route_tables : alltrue([for z in j.static_route : contains(["ecs", "eni", "vip", "nat", "peering", "vpn", "dc", "cc"], z.type)])])
    error_message = "Only ecs, eni, vip, nat, peering, vpn, dc, cc route type supported!"
  }
}

variable "nat_gateway" {
  description = "Nat gateway(s) settings"
  type = any
  default = {}
}

variable "network_acl" {
  description = "Network acl(s) settings"
  type = any
  default = {}
}

variable "eips" {
  description = "EIP(s) settings"
  type = any
  default = {}
}

variable "virtual_ips" {
  description = "Virtual ip(s) settings"
  type = any
  default = {}
}

variable "security_groups" {
  description = "Security group(s) settings"
  type = any
  default = {}
}

variable "snat" {
  description = "SNAT(s) settings"
  type = any
  default = {}
}

variable "dnat" {
  description = "DNAT(s) settings"
  type = any
  default = {}
}


