provider "yandex" {
  service_account_key_file = "key.json"
  cloud_id                 = YOUR_CLOUD_ID
  folder_id                = YOUR_FOLDER_ID
  zone                     = "ru-central1-a"
}
terraform {
  backend "s3" {
    bucket   = "name-your-bucket"
    key      = "name_your_tfstate_for_managed-kubernetes.tfstate"
    region   = "ru-central1"
    endpoint = "https://storage.yandexcloud.net"
    shared_credentials_file = "storage-cred"

    skip_region_validation      = true
    skip_credentials_validation = true
    skip_metadata_api_check     = true
  }
}

data "terraform_remote_state" "vpc" {
  backend = "s3"
  config = {
    bucket   = "name-your-bucket"
    key      = "name_your_tfstate_for_vpc.tfstate"
    region   = "ru-central1"
    endpoint = "https://storage.yandexcloud.net"
    shared_credentials_file = "storage-cred"

    skip_region_validation      = true
    skip_credentials_validation = true
    skip_metadata_api_check     = true
  }
}

module "managed-kubernetes" {
  source = "github.com/nixys/nxs-marketplace-terraform/YandexCloud/Managed-kubernetes/managed-kubernetes"
  
  kubernetes_version = "1.28"

  clusters = {
    name-your-k8s-cluster-1 = {
      description              = "Created by Terraform"
      network_id               = data.terraform_remote_state.vpc.outputs.network_ids["name-your-network-1"]
      service_account_id       = "aje4mf7gnejlqjcmgu72"
      release_channel          = "STABLE"
      cluster_ipv4_range       = "10.233.0.0/18"
      service_ipv4_range       = "10.233.64.0/18"
      node_ipv4_cidr_mask_size = 24
      network_policy_provider  = "CALICO"
      master_version           = "1.28"
      master_public_ip         = false
      security_group_ids       = [data.terraform_remote_state.vpc.outputs.sg_ids["name-your-security-groups-2"], data.terraform_remote_state.vpc.outputs.sg_ids["name-your-security-groups-3"]]
      master_auto_upgrade      = false
      maintenance_window = [{
        day        = "friday"
        start_time = "23:00"
        duration   = "3h30m"
      }]
      kms_provider = [{
#        key_id = "qwefwevewrvbirnb4
      }]
      master_logging = [{
        enabled                    = false
        log_group_id               = ""
        kube_apiserver_enabled     = false
        cluster_autoscaler_enabled = false
        events_enabled             = false
        audit_enabled              = false
      }]

      masters_hosts = [{
        zone      = "ru-central1-a"
        subnet_id = data.terraform_remote_state.vpc.outputs.subnet_ids["name-your-subnet-1"]
      },
      {
        zone      = "ru-central1-b"
        subnet_id = data.terraform_remote_state.vpc.outputs.subnet_ids["name-your-subnet-2"]
      },
      {
        zone      = "ru-central1-d"
        subnet_id = data.terraform_remote_state.vpc.outputs.subnet_ids["name-your-subnet-3"]
      }
      ]

      labels = {
        kubernetes = "name-your-k8s-cluster-1"
      }
    }
  }

  node_groups = {
    name-your-node-group-1 = {
      description  = "Created by Terraform"
      cluster_name = "name-your-k8s-cluster-1"
      node_version = "1.28"
      node_labels  = {
        app = true
      }
      platform_id  = "standard-v2"
      node_groups_default_ssh_keys = {
        test = [
          "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAFDSFEDFWEFVDVHZpf76WKqwerqwerwqerqwerwqerRWEFwewefweUFzLPAIbCIlg+tIHB/PwvlexJ64SOvl3jQMIbg9SDVSDVSDVSDV7LaIGyXwnN08koeSNXP/cUVwFvzLvydu1HfAQJA4c5m9X+VN26kqsoitVFZApZ/0NGyn8XRwxhP2HPWB8d6S1jB+e6CCSgTvtopBHF5q6jVAAZch0cShLhTOpoCSQ1K4OX+bJPB0MaDIPDKj7epkma9X/UMaGe38/WlLudwjt/lxjdGdt9WT+08iPwT94yctATBSoL519IHrEbN0cA9nPEhotq/XIYWJj6zalLVsVDSNcF2QlUoMiP2vO/mxv0Z2GXQeRQGzIzczKK11q7YHjly6JLLXZ1IYLOIdZKwSaLErXb1oj/Qh9dd8Dl3AjOOfSI/LjoS6juW0HHoTZeH7k9abIVditMUFJrfYapQQ7jm/mZ+ewSDl+fcn/BC19pPbmK/ekRt4f+fZSNwLUlNP6opvsteDgexo0zUcn+gNhPVWT1Yp7pcfUs2CdlwP5VDVh4Rgab/gAxt+aydhAHVxlEo6cObxE2Yd77l6duggn9pBCu0YtqogIg0Q/8XMYXSaxbjSvHFa6FbgjAyD0N3cC3idSCH30cA7fIs+PmB+XesmQdmiu176hcY0OGCT+omdhR/hoEDPvzIc2SblDR7ZQ== test@office",
        ]
      }
      resources_cores           = 2
      resources_core_fraction   = 100
      resources_memory          = 2
      resources_gpus            = 0
      boot_disk_type            = "network-hdd"
      boot_disk_size            = 30
      preemptible               = false
      subnet_ids                = [data.terraform_remote_state.vpc.outputs.subnet_ids["name-your-subnet-1"]]
      ipv4                      = true
      ipv6                      = false
      nat                       = true
      security_group_ids        = [data.terraform_remote_state.vpc.outputs.sg_ids["name-your-security-groups-2"], data.terraform_remote_state.vpc.outputs.sg_ids["name-your-security-groups-4"]]
      template_name             = "my-instance-{instance.index}"
      network_acceleration_type = "standard"
      container_runtime         = "containerd"
      instance_labels           = {
        kubernetes = "name-your-node-group-1"
      }

      node_hosts = [{
        zone      = "ru-central1-a"
      }
      ]
      fixed_scale = [{
        size = 1
      }]  
      auto_repair  = true
      auto_upgrade = false
      maintenance_windows = [{
        day        = "monday"
        start_time = "23:00"
        duration   = "4h30m"
      }]
      deploy_policy = [{
        max_expansion   = 2
        max_unavailable = 1
      }]
      labels = {
        kubernetes = "name-your-node-group-1"
      }
    }
  }
}
