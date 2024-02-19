terraform {
  required_version = ">= v1.0.0"

  required_providers {
    sbercloud = {
      source  = "tf.repo.sbc.space/sbercloud-terraform/sbercloud"
      version = ">= 1.11.6"
    }
  }
}