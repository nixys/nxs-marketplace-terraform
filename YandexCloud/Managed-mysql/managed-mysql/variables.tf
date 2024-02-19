#==================== VPC Variables ====================#
variable "clusters" {
  description = "Create Cluster Mysql in VPC"
  type        = any
  default     = {}
}

variable "users" {
  description = "Create users in Mysql cluster"
  type        = any
  default     = {}
}

variable "databases" {
  description = "Create databases in Mysql cluster"
  type        = any
  default     = {}
}
