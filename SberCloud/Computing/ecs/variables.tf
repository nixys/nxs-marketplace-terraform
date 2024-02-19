
variable "general_project_id" {
  description = "Default project"
  type        = string
  default     = null
}

variable "general_region" {
  description = "Default region"
  type        = string
  default     = null
}

variable "ecs" {
  description = "ecs"
  type        = any
  default     = {}
}

variable "keypair" {
  description = "keypair"
  type        = any
  default     = {}
}

