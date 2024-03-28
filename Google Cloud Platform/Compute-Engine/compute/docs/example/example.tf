provider "google" {
  credentials   = file("project-credentials.json")
  project       = YOUR_PROJECT_ID
  region        = YOUR_REGION
}
terraform {
  backend "gcs" {
    bucket      = "name-your-bucket-1"
    prefix      = "terraform/compute/compute/state"
    credentials = "project-credentials.json"
  }
}

module "compute" {
  source = "github.com/nixys/nxs-marketplace-terraform/Google Cloud Platform/Compute-Engine/compute"

  disks = {
    name-your-disk-1 = {
      description = "Created by Terraform"
      zone        = "us-west1-a"
      size        = 35
      type        = "pd-ssd"
      image       = "name-your-image-1"

      labels = {
        disk = "name-your-disk-1"
      }
    }
    name-your-disk-2 = {
      description = "Created by Terraform"
      zone        = "us-west1-a"
      region      = "us-west1"
      size        = 100
      type        = "pd-standard"

      labels = {
        disk = "name-your-disk-2"
      }
    }
  }

  async_disks = {
    name-your-async-disk-1 = {
      description = "Created by Terraform"
      zone        = "us-central1-c"
      region      = "us-central1"
      size        = 35
      type        = "pd-ssd"

      async_primary_disk = [{
        disk_name = "name-your-disk-1"
      }]

      labels = {
        async_disks = "name-your-async-disk-1"
      }
    }
  }

  region_disks = {
    name-your-regional-disk-1 = {
      type                      = "pd-ssd"
      region                    = "us-west1"
      physical_block_size_bytes = 4096
      size                      = 50
      replica_zones             = ["us-west1-a", "us-west1-b"]
    }
  }

  region_async_disks = {
    name-your-regional-async-disk-1 = {
      type                      = "pd-ssd"
      region                    = "us-central1"
      physical_block_size_bytes = 4096
      size                      = 50
      async_primary_disk = [{
        disk_name = "name-your-regional-disk-1"
      }]
      replica_zones             = ["us-central1-a", "us-central1-b"]
    }    
  }

  snapshots = {
    name-your-snapshot-1 = {
      source_disk_name  = "name-your-disk-1"
      zone              = "us-west1-a"
      storage_locations = ["us-west1"]

      labels = {
        snapshot = "name-your-snapshot-1"
      }
    }
  }

  tpu_nodes = {
    name-your-tpu-node-1 = {
      zone                   = "asia-east1-c"
      accelerator_type       = "v2-8"
      tensorflow_version     = "tpu-vm-base"
      use_service_networking = false
      network                = "name-your-network-1"

      scheduling_config = [{
        preemptible = true
      }]

      labels = {
        tpu_node = "name-your-tpu-node-1"
      }
    }
  }

  policys = {
    name-your-policy-1 = {
      description  = "Created by Terraform"
      snapshot_schedule_policy = [{
        schedule = [{
          daily_schedule = [{
            days_in_cycle = 1
            start_time    = "04:00"
          }]
#          hourly_schedule = [{
#            hours_in_cycle = 20
#            start_time     = "23:00"
#          }]
#          weekly_schedule = [{
#            day            = "MONDAY"
#            start_time     = "23:00"    
#          }]
        }]
        retention_policy = [{
          max_retention_days    = 10
          on_source_disk_delete = "KEEP_AUTO_SNAPSHOTS"
        }]
        snapshot_properties  = [{
          storage_locations = ["us"]
          guest_flush       = true
          labels = {
            policy = "name-your-policy-1"
          }
        }]
      }]
#      group_placement_policy = [{
#        vm_count = 2
#        collocation = "COLLOCATED"
#      }]
#      instance_schedule_policy = [{
#        time_zone         = "US/Central"
#        vm_start_schedule = "0 * * * *"
#        vm_stop_schedule  = "15 * * * *"
#      }]
#      disk_consistency_group_policy =  [{
#        enabled = false
#      }]
    }
  }
  
  policy_attachments = {
    name-your-policy-attachment-1 = {
      name = "name-your-policy-1"
      disk = "name-your-disk-1"
      zone = "us-west1-a"
    }
  }

  images = {
    name-your-image-1 = {
      description = "Created by Terraform"
      family      = "common-cpu-debian-11"
      raw_disk = [{
        source = "https://storage.googleapis.com/bosh-gce-raw-stemcells/bosh-stemcell-97.98-google-kvm-ubuntu-xenial-go_agent-raw-1557960142.tar.gz"
      }]
      storage_locations = ["us",]
      guest_os_features = [{
        type = "SECURE_BOOT"
      },
      {
        type = "MULTI_IP_SUBNET"
      }
      ]

      labels = {
        image = "name-your-image-1"
      }
    }
  }
  
  instances = {
    name-your-instance-1 = {
    machine_type = "n2-standard-2"
    zone         = "us-west1-a"
    isntance_default_ssh_keys = {
      admin = [
        "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDmKXbXOXCHwumJ2GoCgfYoU/LCJ+gqQuv2aaA8hEMZwzfax/HkXWWlbBRJkakfHzPFHAOv1vr050tqf1NLPzVG32DVcBjk+Ofl/N9OBkMaDDX1nKzZVbztl7oWqwgvhowlWZcdNlrkn53E35HsZDTRWQa7kZ0bPd6khHBrUxBvQrU4g3C3YNq1vcaTck6sYa1+OiowV7po0SLovtHXZgXgY2eXjdXtPJzzRGHkQqaRMV3LOCwVSy8Z5NoZJFQ9K+9fFUPi9TQF5Uu6AEnM2Ngq2thokJ1lXZ9RB9i3PRvFMgRYRrWi3WliL/tIYU3PSkIPcDlMUAdP0yFZGFnXWcmn8kfi/VcOf/gCnvjBS3bRK9SXgx4rQX6Xjp3+CiubwkkPXav2bjDEC9Ke/o4hkbJ2VoU3ed5cGCZHZ7Cz5EoUrEeYV9oetW8N8n++/pVJUvorccLbGLcTEak64XrSoE0RGTYVZMr/mHANbqLDuuJZj8KV91aboiBhxRNcnTZ8LSk= admin@localhost",
      ]
    }

    boot_disk_auto_delete = true
    source                = "name-your-disk-1"
    subnetwork            = "name-your-subnetwork-1"
    network_ip            = "10.3.0.5"
    attached_disk         = [{
      source = "name-your-disk-2"
    }]
    access_config = [{
      nat_ip = "34.145.101.228"
    }]

    metadata_startup_script = "echo hi > /test.txt"
    labels = {
      instance = "name-your-instance-1"
      }
    }
  }

  instance_groups = {
    name-your-instance-group-1 = {
      zone          = "us-west1-a"
      instance_name = ["name-your-instance-1",]

      named_port = [{
        name = "http"
        port = "8080"
      },
      {
        name = "https"
        port = "8443"
      }]
    }
  }
}
