terraform {
  required_version = ">= v1.0.0"

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 5.17.0"
    }
  }
}