#==================== VPC Variables ====================#
variable "networks" {
  description = "Create Network in VPC"
  type        = any
  default     = {}
}

variable "subnets" {
  description = "Create Subnet(s) in Network"

  type = any

  validation {
    condition     = alltrue([for j in var.subnets : contains(["ru-central1-a", "ru-central1-b", "ru-central1-d"], j.zone)])
    error_message = "Only ru-central1-a, ru-central1-b, ru-central1-d zones supported!"
  }

  validation {
    condition = alltrue([for j in var.subnets: alltrue([for y in j.cidr : length(try(regex("^10\\.|172\\.(1[6-9]|2(0-9)|3[0-1])\\.*|192\\.168\\.*", try(cidrhost(y, 0), false)), "")) > 0 ? true : false])])

    error_message = "Only 10.0.0.0/8, 172.16.0.0/12, 192.168.0.0/16  cidr supported!"
  }

  validation {
    condition     = alltrue([for j in var.subnets: alltrue([for y in j.cidr : tonumber(split("/", y)[1]) >= 16 && tonumber(split("/", y)[1]) <= 28 ? true : false])])
    error_message = "The maximum CIDR size in these ranges is /16, the minimum is /28!"
  }
}

variable "routes" {
  description = "Create routes in vpc"
  type        = any
  default     = {}
}

variable "gateways" {
  description = "Create gateways for routes in vpc"
  type        = any
  default     = {}
}

variable "static_ips" {
  description = "Array of external static ips"

  type = any

  validation {
    condition     = alltrue([for j in var.static_ips : contains(["ru-central1-a", "ru-central1-b", "ru-central1-d"], j.zone)])
    error_message = "Only ru-central1-a, ru-central1-b, ru-central1-d zones supported!"
  }
}

variable "security_groups" {
  description = "Create security-groups for another resource in vpc"
  type        = any
  default     = {}
}
