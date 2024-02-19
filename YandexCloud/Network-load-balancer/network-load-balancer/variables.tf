#==================== VPC Variables ====================#
variable "load_balancers" {
  description = "Create Network Load balancers in VPC"
  type        = any
  default     = {}
}

variable "target_groups" {
  description = "Create target groups for Network Load Balancers"
  type        = any
  default     = {}
}
