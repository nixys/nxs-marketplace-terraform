variable "clusters" {
  description = "Create PostgreSQL cluster"
  type        = any
  default     = {}
}

variable "databases" {
  description = "Create PostgreSQL database"
  type        = any
  default     = {}
}

variable "users" {
  description = "Create PostgreSQL user"
  type        = any
  default     = {}
}