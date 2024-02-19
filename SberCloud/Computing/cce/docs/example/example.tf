provider "sbercloud" {
  auth_url = "https://iam.ru-moscow-1.hc.sbercloud.ru/v3"
  region   = "ru-moscow-1"
}
terraform {
  backend "s3" {
    bucket   = "name-your-bucket"
    key      = "name_your_tfstate_for_cce.tfstate"
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

data "terraform_remote_state" "ecs" {
  backend = "s3"
  config = {
    endpoint = "https://obs.ru-moscow-1.hc.sbercloud.ru"
    bucket   = "name-your-bucket"
    region   = "ru-moscow-1"
    key      = "name_your_tfstate_for_ecs.tfstate"

    skip_region_validation      = true
    skip_credentials_validation = true
    skip_metadata_api_check     = true
  }
}

module "cce" {
  source = "github.com/nixys/nxs-marketplace-terraform/SberCloud/Computing/cce"
  
  general_project_id = data.terraform_remote_state.projects.outputs.project_ids["name_your_project_1"] # Default project
  general_region     = "ru-moscow-1"                                                                   # Default region

  clusters = {
    name-your-cluster-1 = {
      enterprise_project_id  = data.terraform_remote_state.projects.outputs.project_ids["name_your_project_1"]  # Changing this creates a new cluster.
      cluster_type           = "VirtualMachine"                                                                 # Changing this creates a new cluster.
      flavor_id              = "cce.s2.small"           # Required change  Example: "cce.s1.small" (Single-master),"cce.s1.medium" (Single-master), "cce.s2.small" (Multi-master), "cce.s2.medium" (Multi-master), "cce.s2.large" (Multi-master), "cce.s2.xlarge" (Multi-master).
      vpc_id                 = data.terraform_remote_state.vpc.outputs.vpc_ids["name_your_vpc_1"]            # Changing this creates a new cluster.
      subnet_id              = data.terraform_remote_state.vpc.outputs.subnet_ids["name_your_subnet_1"]     # Changing this creates a new cluster.
      container_network_type = "vpc-router"                                                                     # Changing this creates a new cluster.
      authentication_mode    = "rbac"                                                                           # Changing this creates a new cluster.
      description            = "Created by Terraform"
      delete_all             = "true"
      kube_proxy_mode        = "iptables"                                                                       # Changing this creates a new cluster.
      container_network_cidr = "192.168.0.0/20"                                                                  # Changing this creates a new cluster.
      service_network_cidr   = "10.247.0.0/16"                                                                   # Changing this creates a new cluster.
      cluster_version        = "v1.27" # Required change  Example: "v1.27", "v1.25"                          # Changing this creates a new cluster.
      master_zone_list       = ["ru-moscow-1a", "ru-moscow-1c", "ru-moscow-1e"]                                 # Changing this creates a new cluster.
      hibernate              = false
    }
  }

  node_pools ={
    name-your-node-pool-1 = {
      cluster_name                      = "name-your-cluster-1" # Changing this creates a new node-pool.
      os                                = "CentOS 7.6"          # Example: "Ubuntu 18.04", "CentOS 7.6". OS choose by cluster 'container_network_type'. Changing this creates a new node-pool.
      performance_type                  = "normal"         # Required change  Example: "normal", "computingv3", "highmem", "diskintensive". Changing this creates a new node-pool.
      cpu_core_count                    = 2                                                                                # Changing this creates a new node-pool.
      memory_size                       = 4                                                                                # Changing this creates a new node-pool.
      generation                        = "s6" # Required change  Example: "s6", "c6", "m6", "d6" etc...                   # Changing this creates a new node-pool.
      availability_zone                 = "ru-moscow-1a"                                                                   # Changing this creates a new node-pool.
      key_pair                          = "name_for_key_pair_1"                                                            # Changing this creates a new node-pool.
      max_pods                          = "256"                                                                            # Changing this creates a new node-pool.
      runtime                           = "containerd"                                                                     # Changing this creates a new node-pool.
      scall_enable                      = "false"
      min_node_count                    = 0
      max_node_count                    = 0
      scale_down_cooldown_time          = 0
      priority                          = 0
      type                              = "vm"                                                                             # Changing this creates a new node-pool.
      postinstall                       = "echo '127.0.0.1 test' >> /etc/hosts"                                             # Changing this creates a new node-pool.
      preinstall                        = "echo test"                                                                      # Changing this creates a new node-pool.

      labels = {
        "app"        = "true"
        "created_by" = "Terraform"
      }
   
      tags = {
        "created_by" = "Terraform"
        "key"        = "value"
      }

      root_main_volume_size             = 40                                                                                # Changing this creates a new node-pool.
      root_main_volumetype              = "SSD"                                                                             # Changing this creates a new node-pool.
      data_main_volume_size             = 100                                                                               # Changing this creates a new node-pool.
      data_main_volumetype              = "SSD"                                                                             # Changing this creates a new node-pool.
      data_main_kubernetes_virtual_size = "10%"                                                                             # Changing this creates a new node-pool.
      data_main_runtime_virtual_size    = "90%"                                                                             # Changing this creates a new node-pool.
      kms_key_id                        = ""                                                                                # Changing this creates a new node-pool.

      additional_data_disks             = [{
          name  = "data-example-disk"                                                                                       # Changing this creates a new node-pool.
          size = 40                                                                                                         # Changing this creates a new node-pool.
          volumetype = "SSD"                                                                                                # Changing this creates a new node-pool.
          kms_key_id = ""                                                                                                   # Changing this creates a new node-pool.
          virtual_spaces = [{
              name                         = "data-example"                                                                # Changing this creates a new node-pool.
              data_additional_virtual_size = "100%"                                                                         # Changing this creates a new node-pool.
              data_additional_lvm_path     = "/data-example"                                                               # Changing this creates a new node-pool.
            }
          ]
        },
      ]
    }
  }

  #custom_node = {
  #  name-your-custom-node-pool-1 = {
  #    cluster_name                      = "name-your-cluster-1"                                                                  # Changing this creates a new custom node.
  #    os                                = "CentOS 7.6"                                                                           # Changing this creates a new custom node.
  #    performance_type                  = "normal"         # Required change  Example: "normal", "computingv3", "highmem", "diskintensive". Changing this creates a custom node.
  #    cpu_core_count                    = 2                                                                                      # Changing this creates a custom node.
  #    memory_size                       = 4                                                                                      # Changing this creates a new custom node.
  #    generation                        = "s6" # Required change  Example: "s6", "c6", "m6", "d6" etc...                         # Changing this creates a new custom node.
  #    initial_node_count                = 1
  #    availability_zone                 = "ru-moscow-1a"                                                                         # Changing this creates a new custom node.
  #    key_pair                          = "name_for_key_pair_1"                                                                  # Changing this creates a new custom node.
  #    max_pods                          = "256"                                                                                  # Changing this creates a new custom node.
  #    runtime                           = "containerd"                                                                           # Changing this creates a new custom node.
  #    postinstall                       = "echo '127.0.0.1 test' >> /etc/hosts"                                                   # Changing this creates a new custom node.
  #    preinstall                        = "echo test"                                                                            # Changing this creates a new custom node.
  #    eip_id                            = data.terraform_remote_state.vpc.outputs.eip_ids["name_your_eip_3"]                     # Changing this creates a new custom node.
  #    ecs_group_id                      = data.terraform_remote_state.ecs.outputs.ecs_servergroup_ids["name_your_servergroup_1"] # Changing this creates a new custom node.
#
#
  #    labels = {
  #      "app"        = "true"
  #      "created_by" = "Terraform"
  #    }
  # 
  #    tags = {
  #      "created_by" = "Terraform"
  #      "key"        = "value"
  #    }
#
  #    root_main_volume_size             = 40                                                                                     # Changing this creates a new custom node.
  #    root_main_volumetype              = "SSD"                                                                                  # Changing this creates a new custom node.
  #    data_main_volume_size             = 100                                                                                    # Changing this creates a new custom node.
  #    data_main_volumetype              = "SSD"                                                                                  # Changing this creates a new custom node.
  #    data_main_kubernetes_virtual_size = "10%"                                                                                  # Changing this creates a new custom node.
  #    data_main_runtime_virtual_size    = "90%"                                                                                  # Changing this creates a new custom node.
  #    kms_key_id                        = ""                                                                                     # Changing this creates a new custom node.
#
  #    additional_data_disks             = [{
  #        name  = "data-example-disk"                                                                                            # Changing this creates a new custom node.
  #        size = 40                                                                                                              # Changing this creates a new custom node.
  #        volumetype = "SSD"                                                                                                     # Changing this creates a new custom node.
  #        kms_key_id = ""                                                                                                        # Changing this creates a new custom node.
  #        virtual_spaces = [{
  #            name                         = "data-example"                                                                     # Changing this creates a new custom node.
  #            data_additional_virtual_size = "100%"                                                                              # Changing this creates a new custom node.
  #            data_additional_lvm_path     = "/data-example"                                                                    # Changing this creates a new custom node.
  #          }
  #        ]
  #      },
  #    ]
  #  }
  #}

  #addon = {
  #  coredns = {
  #    cluster_name   = "name-your-cluster-1"                                                                                      # Changing this creates a new custom node.
  #    version        = "1.27.4"                                                                                                   # Changing this creates a new custom node.
  #    custom_block   = {
  #      stub_domains = {
  #        "example.ru" : ["10.10.10.1:53"]                                                                                        # Changing this creates a new custom node.
  #      }
  #    }
  #  }
  #}

  namespaces = {
    name-your-namespace-1 = {
      cluster_name = "name-your-cluster-1"                                                                                        # Changing this creates a new custom node.        
      region       = "ru-moscow-1"                                                                                                # Changing this creates a new custom node.
      annotations  = {
        "created_by" = "Terraform"                                                                                                # Changing this creates a new custom node.
      }

      labels = {
        "app"        = "true"                                                                                                     # Changing this creates a new custom node.
        "created_by" = "Terraform"                                                                                                # Changing this creates a new custom node.
      }
    }
  }

  #pvc = {
  #  name-your-pvc-1 = {
  #    cluster_name       = "name-your-cluster-1"                                                                                 # Changing this creates a new custom node.
  #    region             = "ru-moscow-1"                                                                                         # Changing this creates a new custom node.
  #    namespace          = "name-your-namespace-1"                                                                               # Changing this creates a new custom node.
  #    storage_class_name = "ssd"                                                                                                 # Changing this creates a new custom node.
  #    access_modes       = ["ReadWriteOnce"]                                                                                     # Changing this creates a new custom node.
  #    storage            = "10Gi"                                                                                                # Changing this creates a new custom node.
  #
  #    annotations = {
  #      "created_by" = "Terraform"                                                                                               # Changing this creates a new custom node.
  #    }
  #
  #    labels = {
  #      "app"        = "true"                                                                                                    # Changing this creates a new custom node.
  #      "created_by" = "Terraform"                                                                                               # Changing this creates a new custom node.
  #    }
  #  }
  #}

}
