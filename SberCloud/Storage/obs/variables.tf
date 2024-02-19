
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

variable "buckets" {
  description = "Create Bucket"
  type        = any
  default     = {}
}

variable "bucket_acls" {
  description = "Create bucket acls"
  type        = any
  default     = {}
}

variable "bucket_policys" {
  description = "Attaches a policy to an OBS bucket resource."
  type        = any
  default     = {}
}
