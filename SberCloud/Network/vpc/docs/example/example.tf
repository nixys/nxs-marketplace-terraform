provider "sbercloud" {
  auth_url = "https://iam.ru-moscow-1.hc.sbercloud.ru/v3"
  region   = "ru-moscow-1"
}
terraform {
  backend "s3" {
    bucket   = "name-your-bucket"
    key      = "name_your_tfstate_for_vpc.tfstate"
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

module "vpc" {
  source = "github.com/nixys/nxs-marketplace-terraform/SberCloud/Network/vpc"

  providers = {
    sbercloud.requester_provider = sbercloud
    sbercloud.accepter_provider  = sbercloud
  }
  general_project_id = data.terraform_remote_state.projects.outputs.project_ids["name_your_project_1"]
  vpc = {
    name_your_vpc_1 = {
      cidr        = "10.0.0.0/8"
      description = "My Test network"
      project_id  = data.terraform_remote_state.projects.outputs.project_ids["name_your_project_1"]
      tags = {
        created_by = "Terraform"
      }
    },
    name_your_vpc_2 = {
      cidr = "192.168.0.0/16"
    },
  }

  subnets = {
    name_your_subnet_1 = {
      vpc_name     = "name_your_vpc_1"
      cidr       = "10.0.0.0/24"
      gateway_ip = "10.0.0.1"
      tags = {
        created_by = "Terraform"
      }
    },
    name_your_subnet_2 = {
      vpc_name     = "name_your_vpc_1"
      availability_zone = "ru-moscow-1c"
      cidr              = "10.0.1.0/24"
      gateway_ip        = "10.0.1.1"
    },
    name_your_subnet_3 = {
      vpc_name     = "name_your_vpc_2"
      availability_zone = "ru-moscow-1a"
      cidr              = "192.168.0.0/24"
      gateway_ip        = "192.168.0.1"
    },
    name_your_subnet_4 = {
      vpc_name     = "name_your_vpc_2"
      availability_zone = "ru-moscow-1b"
      cidr              = "192.168.1.0/24"
      gateway_ip        = "192.168.1.1"
    }
    name_your_subnet_5 = {
      vpc_name          = "name_your_vpc_2"
      availability_zone = "ru-moscow-1b"
      cidr              = "192.168.2.0/24"
      gateway_ip        = "192.168.2.1"
      ipv6_enable       = true
    }
  }

  peering = {
    name_your_peering_1 = {
      vpc_name      = "name_your_vpc_1"
      peer_vpc_name = "name_your_vpc_2"
    }
  }

  eips = {
    name_your_eip_1 = {
      project_id     = data.terraform_remote_state.projects.outputs.project_ids["name_your_project_1"]
      type           = "5_bgp"
      bandwidth_name = "band-1"
      bandwidth_size = "5"
      charge_mode    = "bandwidth"
    },
    name_your_eip_2 = {
      bandwidth_name = "band-2"
      bandwidth_size = "5"
    },
    name_your_eip_3 = {
      project_id     = data.terraform_remote_state.projects.outputs.project_ids["name_your_project_1"]
      type           = "5_bgp"
      bandwidth_name = "band-1"
      bandwidth_size = "5"
      charge_mode    = "bandwidth"
    },
  }

  virtual_ips = {
    name_your_vip_1 = {
      network_name = "name_your_subnet_1"
      ip_address = "10.0.0.10"
    },
    name_your_vip_2 = {
      network_name = "name_your_subnet_2"
    }
  }

  nat_gateway = {
    name_your_nat_1 = {
      vpc_name     = "name_your_vpc_1"
      spec       = "1"
      subnet_name  = "name_your_subnet_1"
      project_id = data.terraform_remote_state.projects.outputs.project_ids["name_your_project_1"]
    },
    name_your_nat_2 = {
      vpc_name    = "name_your_vpc_2"
      spec      = "1"
      subnet_name = "name_your_subnet_3"
    }
  }

  snat = {
    name_for_snat_1 = {
      nat_gateway_name = "name_your_nat_1"
      subnet_name      = "name_your_subnet_1"
      floating_ip_name = "name_your_eip_2"
    }
  }

  dnat = {
    name_for_dnat_1 = {
      nat_gateway_name        = "name_your_nat_1"
      floating_ip_name        = "name_your_eip_2"
      private_ip            = "10.0.0.12"
      protocol              = "tcp"
      internal_service_port = "339"
      external_service_port = "993"
    }
  }

  network_acl = {
    name_your_nacl_1 = {
      description = "Network ACL for testing"
      subnet_names = [
        "name_your_subnet_1",
        "name_your_subnet_2",
      ]
      inbound_rules = {
        name_your_inbound_rules_1 = {
          protocol               = "any"
          action                 = "allow"
          ip_version             = "4"
          source_ip_address      = "0.0.0.0/0"
          source_port            = ""
          destination_ip_address = "0.0.0.0/0"
          destination_port       = ""
          description            = "Created by Terraform"
        },
        name_your_inbound_rules_2 = {
          protocol               = "tcp"
          action                 = "allow"
          ip_version             = "4"
          source_ip_address      = "0.0.0.0/0"
          source_port            = "133"
          destination_ip_address = "0.0.0.0/0"
          destination_port       = "133"
          description            = "Created by Terraform"
        }
      }
      outbound_rules = {
        name_your_outbound_rules_1 = {
          protocol               = "any"
          source_ip_address      = "0.0.0.0/0"
          source_port            = ""
          destination_ip_address = "0.0.0.0/0"
          destination_port       = ""
          description            = "Created by Terraform"
        },
        name_your_outbound_rules_2 = {
          source_ip_address      = "0.0.0.0/0"
          source_port            = "2222"
          destination_ip_address = "0.0.0.0/0"
          destination_port       = "2222"
          description            = "Created by Terraform"
        }
      }
    },
    name_your_nacl_2 = {
      description = "Network ACL for testing"
      subnet_names = [
        "name_your_subnet_3",
        "name_your_subnet_4",
      ]
      inbound_rules = {
        name_your_inbound_rules_1 = {
          protocol               = "any"
          action                 = "allow"
          ip_version             = "4"
          source_ip_address      = "0.0.0.0/0"
          source_port            = ""
          destination_ip_address = "0.0.0.0/0"
          destination_port       = ""
          description            = "Created by Terraform"
        }
      }
    }
  }

  security_groups = {
    name_your_security_group_1 = {
      project_id = data.terraform_remote_state.projects.outputs.project_ids["name_your_project_1"]
      ingress_rules = {
        name_your_ingress_rules_01 = {
          ethertype        = "IPv4"
          description      = "allow Kubernetes_network. Created by Terraform"
          remote_ip_prefix = "0.0.0.0/0" # Required change
        }
        name_your_ingress_rules_02 = {
          ethertype        = "IPv4"
          description      = "allow Kubernetes_network. Created by Terraform"
          remote_ip_prefix = "172.22.241.0/24" # Required change
        }
        name_your_ingress_rules_03 = {
          ethertype        = "IPv4"
          description      = "allow Server_subnet. Created by Terraform"
          remote_ip_prefix = "172.22.240.0/24" # Required change
        }
      }
    }
    name_your_security_group_2 = {
      ingress_rules = {
        name_your_ingress_rules_01 = {
          ethertype        = "IPv4"
          description      = "allow Kubernetes_network. Created by Terraform"
          remote_ip_prefix = "0.0.0.0/0" # Required change
        }
        name_your_ingress_rules_02 = {
          ethertype        = "IPv4"
          description      = "allow Kubernetes_network. Created by Terraform"
          remote_ip_prefix = "172.22.241.0/24" # Required change
        }
        name_your_ingress_rules_03 = {
          ethertype        = "IPv4"
          description      = "allow Server_subnet. Created by Terraform"
          remote_ip_prefix = "172.22.240.0/24" # Required change
        }
      }
      egress_rules = {
        name_your_egress_rules_01 = {
          ethertype        = "IPv4"
          description      = "allow Kubernetes_network. Created by Terraform"
          remote_ip_prefix = "0.0.0.0/0" # Required change
        }
        name_your_egress_rules_02 = {
          ethertype        = "IPv4"
          description      = "allow Kubernetes_network. Created by Terraform"
          remote_ip_prefix = "172.22.241.0/24" # Required change
        }
        name_your_egress_rules_03 = {
          ethertype        = "IPv4"
          description      = "allow Server_subnet. Created by Terraform"
          remote_ip_prefix = "172.22.240.0/24" # Required change
        }
      }
    }
  }
}

### ========= OUTPUTS ========== ###

output "vpc_names" {
  value = module.vpc.vpc_names
}

output "vpc_ids" {
  value = module.vpc.vpc_ids
}

output "vpc_cidrs" {
  value = module.vpc.vpc_cidrs
}

output "subnet_names" {
  value = module.vpc.subnet_names
}

output "subnet_ids" {
  value = module.vpc.subnet_ids
}

output "subnet_ipv4_ids" {
  value = module.vpc.subnet_ipv4_ids
}

output "subnet_ipv6_ids" {
  value = module.vpc.subnet_ipv6_ids
}

output "peering_names" {
  value = module.vpc.peering_names
}

output "peering_ids" {
  value = module.vpc.peering_ids
}

output "accepter_peering_names" {
  value = module.vpc.accepter_peering_names
}

output "accepter_peering_ids" {
  value = module.vpc.accepter_peering_ids
}

output "eip_addresses" {
  value = module.vpc.eip_addresses
}

output "eip_ids" {
  value = module.vpc.eip_ids
}

output "virtual_ip_names" {
  value = module.vpc.virtual_ip_names
}

output "virtual_ip_addresses" {
  value = module.vpc.virtual_ip_addresses
}

output "nat_gateway_names" {
  value = module.vpc.nat_gateway_names
}

output "nat_gateway_ids" {
  value = module.vpc.nat_gateway_ids
}

output "network_acl_names" {
  value = module.vpc.network_acl_names
}

output "network_acl_ids" {
  value = module.vpc.network_acl_ids
}

output "network_acl_inbound_rules_names" {
  value = module.vpc.network_acl_inbound_rules_names
}

output "network_acl_inbound_rules_ids" {
  value = module.vpc.network_acl_inbound_rules_ids
}

output "network_acl_outbound_rules_names" {
  value = module.vpc.network_acl_outbound_rules_names
}

output "network_acl_outbound_rules_ids" {
  value = module.vpc.network_acl_outbound_rules_ids
}

output "security_group_names" {
  value = module.vpc.security_group_names
}

output "security_group_ids" {
  value = module.vpc.security_group_ids
}

output "security_group_ingress_rules_names" {
  value = module.vpc.security_group_ingress_rules_names
}

output "security_group_ingress_rules_ids" {
  value = module.vpc.security_group_ingress_rules_ids
}

output "security_group_egress_rules_names" {
  value = module.vpc.security_group_egress_rules_names
}

output "security_group_egress_rules_ids" {
  value = module.vpc.security_group_egress_rules_ids
}

output "snat_ids" {
  value = module.vpc.snat_ids
}

output "dnat_ids" {
  value = module.vpc.dnat_ids
}
