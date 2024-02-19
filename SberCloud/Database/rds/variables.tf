
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

variable "instance" {
  description = "Create Instance Database"
  type        = any
  default     = {}
}

variable "custom_database_template" {
  description = "Create custom database template"
  type        = any
  default     = {}
}

variable "custom_database_backup" {
  description = "Add custom database backup"
  type        = any
  default     = {}
}

variable "custom_replicas" {
  description = "Create custom replicas and attach to instance database"
  type        = any
  default     = {}
}
