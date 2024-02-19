provider "yandex" {
  service_account_key_file = "key.json"
  cloud_id                 = YOUR_CLOUD_ID
  folder_id                = YOUR_FOLDER_ID
  zone                     = "ru-central1-a"
}
terraform {
  backend "s3" {
    bucket   = "name-your-bucket"
    key      = "name_your_tfstate_for_compute.tfstate"
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

module "compute" {
  source = "github.com/nixys/nxs-marketplace-terraform/YandexCloud/Compute/compute"

  disks = {
    name-your-disk-1 = {
      description = "Created by Terraform"
      zone        = "ru-central1-a"
      size        = 30
      type        = "network-hdd"
      image_name  = "name-your-image-1"

      labels = {
        disk = "name-your-disk-1"
      }
    }
    name-your-disk-2 = {
      description           = "Created by Terraform"
      zone                  = "ru-central1-a"
      size                  = 93
      type                  = "network-ssd-nonreplicated"
      image_name            = "name-your-image-1"
      disk_placement_policy = [{
        disk_placement_group_name = "name-your-disk-placement-groups-1"
      }]

      labels = {
        disk = "name-your-disk-2"
      }
    }
  }

  disks_from_snapshot = {
    name-your-disk-from-snapshot-1 = {
      description   = "Created by Terraform"
      zone          = "ru-central1-a"
      size          = 30
      type          = "network-hdd"
      image_name    = "name-your-image-1"
      snapshot_name = "name-your-snapshot-1"

      labels = {
        disk-from-snapshot = "name-your-disk-from-snapshot-1"
      }
    }
  }

  disk_placement_groups = {
    name-your-disk-placement-groups-1 = {
      description = "Created by Terraform"
      zone        = "ru-central1-a"

      labels = {
        disk-placement-group = "name-your-disk-placement-groups-1"
      }
    }
  }

  filesystems = {
    name-your-filesystem-1 = {
      description   = "Created by Terraform"
      zone          = "ru-central1-a"
      size          = 10
      type          = "network-hdd"

      labels = {
        filesystem = "name-your-filesystem-1"
      }
    }
  }

#  gpu_clusters = {
#    name-your-gpu-cluster-1 = {
#      description       = "Created by Terraform"
#      zone              = "ru-central1-a"
#      interconnect_type = "infiniband"
#
#      labels = {
#        gpu-cluster = "name-your-gpu-cluster-1"
#      }
#    }
#  }

  images = {
    name-your-image-1 = {
      description     = "Created by Terraform"
      family          = "ubuntu-2204-lts"
      min_disk_size   = 10
      os_type         = "LINUX"
      source_family   = "ubuntu-2204-lts"

      labels = {
        image = "name-your-image-1"
      }
    }
  }

  instances = {
    name-your-instance-1 = {
      description               = "Created by Terraform"
      zone                      = "ru-central1-a"
      platform_id               = "standard-v1"
      isntance_default_ssh_keys = {
        test = [
          "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAFDSFEDFWEFVDVHZpf76WKqwerqwerwqerqwerwqerRWEFwewefweUFzLPAIbCIlg+tIHB/PwvlexJ64SOvl3jQMIbg9SDVSDVSDVSDV7LaIGyXwnN08koeSNXP/cUVwFvzLvydu1HfAQJA4c5m9X+VN26kqsoitVFZApZ/0NGyn8XRwxhP2HPWB8d6S1jB+e6CCSgTvtopBHF5q6jVAAZch0cShLhTOpoCSQ1K4OX+bJPB0MaDIPDKj7epkma9X/UMaGe38/WlLudwjt/lxjdGdt9WT+08iPwT94yctATBSoL519IHrEbN0cA9nPEhotq/XIYWJj6zalLVsVDSNcF2QlUoMiP2vO/mxv0Z2GXQeRQGzIzczKK11q7YHjly6JLLXZ1IYLOIdZKwSaLErXb1oj/Qh9dd8Dl3AjOOfSI/LjoS6juW0HHoTZeH7k9abIVditMUFJrfYapQQ7jm/mZ+ewSDl+fcn/BC19pPbmK/ekRt4f+fZSNwLUlNP6opvsteDgexo0zUcn+gNhPVWT1Yp7pcfUs2CdlwP5VDVh4Rgab/gAxt+aydhAHVxlEo6cObxE2Yd77l6duggn9pBCu0YtqogIg0Q/8XMYXSaxbjSvHFa6FbgjAyD0N3cC3idSCH30cA7fIs+PmB+XesmQdmiu176hcY0OGCT+omdhR/hoEDPvzIc2SblDR7ZQ== test@office",
        ]
      }
      service_account_id        = "aje4mf7gnejlqjcmgu72"
      allow_stopping_for_update = false
      network_acceleration_type = "standard"
      maintenance_policy        = "unspecified"
      maintenance_grace_period  = "1m"
      preemptible               = false
      resources_cores            = 2
      resources_memory           = 2
      resources_core_fraction    = 20
      boot_disk                 = [{
        auto_delete       = true
        mode              = "READ_WRITE"
        disk_name         = "name-your-disk-1"
        initialize_params = [{
          description   = "Created by Terraform"
          size          = 10
          type          = "network-hdd"
          image_name    = ""
          snapshot_name = ""
        }]
      }]
      subnet_id                 = data.terraform_remote_state.vpc.outputs.subnet_ids["name-your-subnet-1"]
      ipv4                      = true
      nat                       = true
      security_group_ids        = [data.terraform_remote_state.vpc.outputs.sg_ids["name-your-security-groups-1"]]

      labels = {
        instance = "name-your-instance-1"
      }
    }
    name-your-instance-2 = {
      description               = "Created by Terraform"
      zone                      = "ru-central1-a"
      platform_id               = "standard-v1"
      isntance_default_ssh_keys = {
        test = [
          "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAFDSFEDFWEFVDVHZpf76WKqwerqwerwqerqwerwqerRWEFwewefweUFzLPAIbCIlg+tIHB/PwvlexJ64SOvl3jQMIbg9SDVSDVSDVSDV7LaIGyXwnN08koeSNXP/cUVwFvzLvydu1HfAQJA4c5m9X+VN26kqsoitVFZApZ/0NGyn8XRwxhP2HPWB8d6S1jB+e6CCSgTvtopBHF5q6jVAAZch0cShLhTOpoCSQ1K4OX+bJPB0MaDIPDKj7epkma9X/UMaGe38/WlLudwjt/lxjdGdt9WT+08iPwT94yctATBSoL519IHrEbN0cA9nPEhotq/XIYWJj6zalLVsVDSNcF2QlUoMiP2vO/mxv0Z2GXQeRQGzIzczKK11q7YHjly6JLLXZ1IYLOIdZKwSaLErXb1oj/Qh9dd8Dl3AjOOfSI/LjoS6juW0HHoTZeH7k9abIVditMUFJrfYapQQ7jm/mZ+ewSDl+fcn/BC19pPbmK/ekRt4f+fZSNwLUlNP6opvsteDgexo0zUcn+gNhPVWT1Yp7pcfUs2CdlwP5VDVh4Rgab/gAxt+aydhAHVxlEo6cObxE2Yd77l6duggn9pBCu0YtqogIg0Q/8XMYXSaxbjSvHFa6FbgjAyD0N3cC3idSCH30cA7fIs+PmB+XesmQdmiu176hcY0OGCT+omdhR/hoEDPvzIc2SblDR7ZQ== test@office",
        ]
      }
      service_account_id        = "aje4mf7gnejlqjcmgu72"
      allow_stopping_for_update = false
      network_acceleration_type = "standard"
#      gpu_cluster_name          = "name-your-gpu-cluster-1"
      maintenance_policy        = "unspecified"
      maintenance_grace_period  = "1m"
      preemptible               = false
      resources_cores            = 2
      resources_memory           = 2
      resources_core_fraction    = 20
      placement_group_name      = "name-your-placement-group-1"
      boot_disk                 = [{
        auto_delete       = true
        mode              = "READ_WRITE"
        disk_name         = ""
        initialize_params = [{
          description     = "Created by Terraform"
          size            = 10
          type            = "network-hdd"
          image_name      = "name-your-image-1"
          snapshot_name   = ""
        }]
      }]
      filesystem                = [{
        filesystem_name = "name-your-filesystem-1"
        mode            = "READ_WRITE"
      }]
      subnet_id                 = data.terraform_remote_state.vpc.outputs.subnet_ids["name-your-subnet-1"]
      ipv4                      = true
      nat                       = true
      security_group_ids        = [data.terraform_remote_state.vpc.outputs.sg_ids["name-your-security-groups-1"]]

      labels = {
        instance = "name-your-instance-2"
      }
    }
  }

  instance_groups = {
    name-your-instance-group-1 = {
      service_account_id       = "aje4mf7gnejlqjcmgu72"
      deletion_protection      = false
      platform_id              = "standard-v1"
      template_name            = "my-instance-{instance.index}"
      description              = "Created by Terraform"
      fixed_scale              = [{
        size = 2
      }]
      deploy_policy  = [{
        max_expansion   = 2
        max_unavailable = 1
        max_creating    = 2
        max_expansion   = 2
        max_deleting    = 2
      }]
      isntance_default_ssh_keys = {
        test = [
          "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAFDSFEDFWEFVDVHZpf76WKqwerqwerwqerqwerwqerRWEFwewefweUFzLPAIbCIlg+tIHB/PwvlexJ64SOvl3jQMIbg9SDVSDVSDVSDV7LaIGyXwnN08koeSNXP/cUVwFvzLvydu1HfAQJA4c5m9X+VN26kqsoitVFZApZ/0NGyn8XRwxhP2HPWB8d6S1jB+e6CCSgTvtopBHF5q6jVAAZch0cShLhTOpoCSQ1K4OX+bJPB0MaDIPDKj7epkma9X/UMaGe38/WlLudwjt/lxjdGdt9WT+08iPwT94yctATBSoL519IHrEbN0cA9nPEhotq/XIYWJj6zalLVsVDSNcF2QlUoMiP2vO/mxv0Z2GXQeRQGzIzczKK11q7YHjly6JLLXZ1IYLOIdZKwSaLErXb1oj/Qh9dd8Dl3AjOOfSI/LjoS6juW0HHoTZeH7k9abIVditMUFJrfYapQQ7jm/mZ+ewSDl+fcn/BC19pPbmK/ekRt4f+fZSNwLUlNP6opvsteDgexo0zUcn+gNhPVWT1Yp7pcfUs2CdlwP5VDVh4Rgab/gAxt+aydhAHVxlEo6cObxE2Yd77l6duggn9pBCu0YtqogIg0Q/8XMYXSaxbjSvHFa6FbgjAyD0N3cC3idSCH30cA7fIs+PmB+XesmQdmiu176hcY0OGCT+omdhR/hoEDPvzIc2SblDR7ZQ== test@office",
        ]
      }
      resources_cores           = 2
      resources_core_fraction   = 20
      resources_memory          = 2
      boot_disk                 = [{
        mode              = "READ_WRITE"
        initialize_params = [{
          description     = "Created by Terraform"
          size            = 10
          type            = "network-hdd"
          image_name      = "name-your-image-1"
          snapshot_name   = ""
        }]
      }]
      preemptible               = false
      placement_group_name      = "name-your-placement-group-1"
      network_id                = data.terraform_remote_state.vpc.outputs.network_ids["name-your-network-1"]
      subnet_ids                = [data.terraform_remote_state.vpc.outputs.subnet_ids["name-your-subnet-1"], data.terraform_remote_state.vpc.outputs.subnet_ids["name-your-subnet-2"]]
      nat                       = true
      security_group_ids        = [data.terraform_remote_state.vpc.outputs.sg_ids["name-your-security-groups-1"]]
      secondary_disk            = [{
        mode              = "READ_WRITE"
        initialize_params = [{
          description     = "Created by Terraform"
          size            = 10
          type            = "network-hdd"
          image_name      = ""
          snapshot_name   = ""
        }]
      }]
      network_settings          = "STANDARD"
      allocation_policy_zones   = ["ru-central1-a", "ru-central1-b"]
      variables                 = {
        test_key1 = "test_value1"
      }
      labels                    = {
        instance-group = "name-your-instance-group-1"
      }
    }
  }

  placement_groups = {
    name-your-placement-group-1 = {
      description = "Created by Terraform"

      labels = {
        placement-group = "name-your-placement-group-1"
      }
    }
  }

  snapshots = {
    name-your-snapshot-1 = {
      disk_name   = "name-your-disk-1"
      description = "Created by Terraform"

      labels = {
        snapshot = "name-your-snapshot-1"
      }
    }
  }

  snapshots_shedule = {
    name-your-snapshots-shedule-1 = {
      description      = "Created by Terraform"
      retention_period = "12h"
      snapshot_count   = 1
      schedule_policy  = [{
        expression = "0 0 * * *"
        start_at   = ""
      }]
      snapshot_spec    = [{
        description         = "Created by Terraform"
        labels = {
          snapshots-shedule = "name-your-snapshots-shedule-1"
        }
      }]

      labels = {
        snapshots-shedule = "name-your-snapshots-shedule-1"
      }
    }
  }
}
