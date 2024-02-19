provider "sbercloud" {
  auth_url = "https://iam.ru-moscow-1.hc.sbercloud.ru/v3"
  region   = "ru-moscow-1"
}
terraform {
  backend "s3" {
    bucket   = "name-your-bucket"
    key      = "name_your_tfstate_for_ecs.tfstate"
    region   = "ru-moscow-1"
    endpoint = "https://obs.ru-moscow-1.hc.sbercloud.ru"

    skip_region_validation      = true
    skip_credentials_validation = true
    skip_metadata_api_check     = true
  }
}

data "terraform_remote_state" "projects" {
  backend = "s3"
  config = {
    endpoint = "https://obs.ru-moscow-1.hc.sbercloud.ru"
    bucket   = "name-your-bucket"
    region   = "ru-moscow-1"
    key      = "name_your_tfstate_for_projects.tfstate"

    skip_region_validation      = true
    skip_credentials_validation = true
    skip_metadata_api_check     = true
  }
}

data "terraform_remote_state" "vpc" {
  backend = "s3"
  config = {
    endpoint = "https://obs.ru-moscow-1.hc.sbercloud.ru"
    bucket   = "name-your-bucket"
    region   = "ru-moscow-1"
    key      = "name_your_tfstate_for_vpc.tfstate"

    skip_region_validation      = true
    skip_credentials_validation = true
    skip_metadata_api_check     = true
  }
}

module "ecs" {
  source = "github.com/nixys/nxs-marketplace-terraform/SberCloud/Computing/ecs"

  general_project_id = data.terraform_remote_state.projects.outputs.project_ids["name_your_project_1"] # Default project
  general_region     = "ru-moscow-1"                                                                   # Default region
  keypair = {
    name_for_key_pair_1 = {
      key_file = "name_for_key_pair_file.pem"
    },
    name_for_key_pair_2 = {
      public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCsjSb7+e6wZ+MgkKBovQp4JD8jwWtFr6VAXb+enVoa7xmr/p14++P+HQGKufm6d3huCPpR/NBqqwZ08HR+SthYABSYOTrFdnefgTFBdajSXK749zRDGHHNLWNaYMhrIhmppi4yNAAnTtk2KTXJ09cTcCkD7BzHe2cS5JX3K669bxlMqwmTXsvmkQXIh8k4KY7npNb14gAe52hkk0E0FhEfjAyrCHPR+UCRTtlbeJP4iGF58jMbDx0bV9OphBwILvBLgpNkDP43ICthQleFNnE9sJ2VkyoD4rbmpiKYhNjI6SZgg1SR6F9RrG0jGwY+5KeGJT4IEzldsGBy2rBsApS9ytZaTArORO2pr+AffjqILSnFPUCDDn1COcItFK1jAyJCQYTLjZxkCry1w1NxJYqEMgDrcVsxhVX68O1Uhzv8TQAfHpj5KkgNJNpCCM66kKNuPiVh+90aPwnPUt00QGq+K24XXRbW/9BPVm6uvvYd54HvfAwDygfiEvRobDGLmSc= example@example" # YOUR_SSH_PUBLIC_KEY
    }
  } # You may not specify this parameter if you are using an existing keypair or using a password
  ecs = {
    name_your_instance_1 = {
      system_disk_type = "SAS"                                                                           # Changing this creates a new instance.
      system_disk_size = 20                                                                              # Changing this creates a new instance.
      project_id       = data.terraform_remote_state.projects.outputs.project_ids["name_your_project_1"] # Your project id
      network = [
        {
          uuid        = data.terraform_remote_state.vpc.outputs.subnet_ids["name_your_subnet_1"]
          fixed_ip_v4 = "10.0.0.126"
        },
      ]                                           # Required change. Changing this creates a new instance. To connect additional subnets, use the interface_attach parameter
      image_os_name       = "Debian 11.3.0 64bit" # Required change. Changing this creates a new instance.
      image_os_visibility = "public"              # Default value "public". Changing this creates a new instance.
      performance_type    = "computingv3"         # Required change  Example: "normal", "computingv3", "highmem", "diskintensive". Changing this creates a new instance.
      cpu_core_count      = 4
      memory_size         = 8
      generation          = "c6" # Required change  Example: "s6", "s7", "m3", "c6" etc...
      security_group_ids  = ["${data.terraform_remote_state.vpc.outputs.security_group_ids["name_your_security_group_1"]}"]
      availability_zone   = "ru-moscow-1a"       # ForceNew VM
      servergroup_name    = "name_your_servergroup_1" # If you want to combine several servers into groups, specify the name of the server group in the servergroup_name parameter
      eip = {
        eip_1 = {
          public_ip = data.terraform_remote_state.vpc.outputs.eip_addresses["name_your_eip_1"]
          fixed_ip  = "10.0.1.2"
        },
      }                                # If you want to assign eip use this parameter
      key_pair = "name_for_key_pair_2" # Use key_pair or admin_pass to access the virtual machine. A keypair must be created for key_pair
      # admin_pass = "YOUR_PASSWORD" # Use key_pair or admin_pass to access the virtual machine.
      user_data = "#cloud-config\nhostname: instance_1.example.com\nfqdn: instance_1.example.com" # Changing this creates a new instance. Specifies the user data to be injected during the instance creation.
      tags = {
        created_by = "Terraform"
      }
      interface_attach = {
        interface_attach_1 = {
          network_id = data.terraform_remote_state.vpc.outputs.subnet_ids["name_your_subnet_2"]
          fixed_ip   = "10.0.1.2"
        },
      } # If you want to join subnets use this parameter
      data_disks = {
        name_your_volume_1 = {
          size = 5
        },
        name_your_volume_2 = {
          volume_type = "SAS"
          size        = 5
          project_id  = data.terraform_remote_state.projects.outputs.project_ids["name_your_project_1"]
        }
      } # If you want to create and connect data disks use this parameter
    },
    name_your_instance_2 = {
      system_disk_size = 100 # ForceNew VM
      project_id       = data.terraform_remote_state.projects.outputs.project_ids["name_your_project_1"]
      network = [
        {
          uuid = data.terraform_remote_state.vpc.outputs.subnet_ids["name_your_subnet_2"]
        },
      ]
      image_os_name     = "Debian 11.3.0 64bit"
      cpu_core_count    = 2
      memory_size       = 4
      availability_zone = "ru-moscow-1a"    # ForceNew VM    
      admin_pass        = "JBhkxc8G9rNS9Wk" # YOUR_PASSWORD
      data_disks = {
        name_your_volume_1 = {
          size = 100
        },
      }
    },
  }
}

### ========= OUTPUTS ========== ###

output "keypair_public_key" {
  value = module.ecs.keypair_public_key
}

output "ecs_servergroup_member_names" {
  value = module.ecs.ecs_servergroup_member_names
}

output "ecs_servergroup_ids" {
  value = module.ecs.ecs_servergroup_ids
}

output "ecs_names" {
  value = module.ecs.ecs_names
}

output "ecs_ids" {
  value = module.ecs.ecs_ids
}

output "ecs_private_ip_v4" {
  value = module.ecs.ecs_private_ip_v4
}

output "ecs_private_ip_v6" {
  value = module.ecs.ecs_private_ip_v6
}

output "ecs_security_group_ids" {
  value = module.ecs.ecs_security_group_ids
}

output "ecs_security_group_names" {
  value = module.ecs.ecs_security_group_names
}

output "ecs_image_ids" {
  value = module.ecs.ecs_image_ids
}

output "ecs_attached_data_disk_names" {
  value = module.ecs.ecs_attached_data_disk_names
}

output "ecs_attached_data_disk_ids" {
  value = module.ecs.ecs_attached_data_disk_ids
}

output "ecs_attached_interface_names" {
  value = module.ecs.ecs_attached_interface_names
}

output "ecs_attached_interface_ids" {
  value = module.ecs.ecs_attached_interface_ids
}

output "ecs_attached_eip_public_ips" {
  value = module.ecs.ecs_attached_eip_public_ips
}

output "ecs_attached_eip_ids" {
  value = module.ecs.ecs_attached_eip_ids
}
