terraform {
  required_version = ">= v1.0.0"

  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = ">= 0.107.0"
    }
  }
}
