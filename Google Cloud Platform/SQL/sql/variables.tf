variable "databases" {
  description = "Create database in Cloud SQL"
  type        = any
  default     = {}
}

variable "database_instances" {
  description = "Create instance for databases in Cloud SQL"
  type        = any
  default     = {}
}

variable "source_representation_instances" {
  description = "Create a source representation instance is a Cloud SQL instance that represents the source database server to the Cloud SQL replica."
  type        = any
  default     = {}
}

variable "ssl_certs" {
  description = "Creates a new Google SQL SSL Cert on a Google SQL Instance."
  type        = any
  default     = {}
}

variable "users" {
  description = "Creates a new Google SQL User on a Google SQL User Instance."
  type        = any
  default     = {}
}
