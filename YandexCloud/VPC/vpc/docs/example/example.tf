provider "yandex" {
  service_account_key_file = "key.json"
  cloud_id                 = YOUR_CLOUD_ID
  folder_id                = YOUR_FOLDER_ID
  zone                     = "ru-central1-a"
}
terraform {
  backend "s3" {
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

module "vpc" {
  source = "github.com/nixys/nxs-marketplace-terraform/YandexCloud/VPC/vpc"
  
  networks = {
    name-your-network-1 = {
      description = "Created by Terraform"
      labels = {
        network = "name-your-network-1"
      }
    }
  }
  subnets = {
    name-your-subnet-1 = {
      description      = "Created by Terraform"
      network_name     = "name-your-network-1"
      cidr             = ["10.2.0.0/16"]
      zone             = "ru-central1-a"
      route_table_name = "name-your-route-1"
      labels = {
        subnet = "name-your-subnet-1"
      }
    }
    name-your-subnet-2 = {
      description      = "Created by Terraform"
      network_name     = "name-your-network-1"
      cidr             = ["10.3.0.0/16"]
      zone             = "ru-central1-b"
      route_table_name = "name-your-route-1"
      labels = {
        subnet = "name-your-subnet-2"
      }
    }
    name-your-subnet-3 = {
      description      = "Created by Terraform"
      network_name     = "name-your-network-1"
      cidr             = ["10.5.0.0/16"]
      zone             = "ru-central1-d"
      route_table_name = "name-your-route-1"
      labels = {
        subnet = "name-your-subnet-3"
      }
    }
  }
  gateways = {
    name-your-gateway-1 = {
      description      = "Created by Terraform"
      labels = {
        gateway = "name-your-gateway-1"
      }
    }
  }
  routes = {
    name-your-route-1 = {
      description      = "Created by Terraform"
      network_name     = "name-your-network-1"
      static_route     = [{
        need_gateway       = "true"
        destination_prefix = "0.0.0.0/0"
        gateway_name       = "name-your-gateway-1"
      },
      {
        need_gateway       = "false"
        destination_prefix = "10.4.0.0/16"
        next_hop_address   = "10.3.2.10"
      },
      ]
      labels = {
        route = "name-your-route-1"
      }
    }
  }
  static_ips = {
    name-your-static-ip-1 = {
      description              = "Created by Terraform"
      deletion_protection      = false
      zone                     = "ru-central1-a"
      ddos_protection_provider = ""
      outgoing_smtp_capability = ""
      labels = {
        static-ip = "name-your-static-ip-1"
      }
    }
  }
  security_groups = {
    name-your-security-groups-1 = {
      description              = "Created by Terraform"
      network_name             = "name-your-network-1"
      firewall_ingress_rules = [{
        protocol       = "ANY"
        description    = "rule1 description"
        v4_cidr_blocks = ["10.0.1.0/24", "10.0.2.0/24"]
        from_port      = 8080
        to_port        = 8080
      },
      {
        protocol       = "ANY"
        description    = "rule2 description"
        v4_cidr_blocks = ["10.0.1.0/24", "10.0.2.0/24"]
        from_port      = 8090
        to_port        = 8099
      },
      ]
      firewall_egress_rules = [{
        protocol       = "UDP"
        description    = "rule3 description"
        v4_cidr_blocks = ["10.0.1.0/24"]
        from_port      = 8090
        to_port        = 8099
      }]
      labels = {
        security-group = "name-your-security-group-1"
      }
    }
    name-your-security-groups-2 = {
      description              = "Created by Terraform"
      network_name             = "name-your-network-1"
      firewall_ingress_rules = [{
        protocol          = "TCP"
        description       = "Правило разрешает проверки доступности с диапазона адресов балансировщика нагрузки. Нужно для работы отказоустойчивого кластера и сервисов балансировщика."
        predefined_target = "loadbalancer_healthchecks"
        from_port         = 0
        to_port           = 65535
      },
      {
        protocol          = "ANY"
        description       = "Правило разрешает взаимодействие мастер-узел и узел-узел внутри группы безопасности."
        predefined_target = "self_security_group"
        from_port         = 0
        to_port           = 65535
      },
      {
        protocol       = "ANY"
        description    = "Rule allows all incoming traffic. Nodes can connect to Yandex Container Registry, Yandex Object Storage, Docker Hub, and so on."
        v4_cidr_blocks = ["10.10.0.0/16"]
        from_port      = 0
        to_port        = 65535
      }
      ]
      firewall_egress_rules = [{
        protocol          = "ANY"
        description       = "self"
        predefined_target = "self_security_group"
        from_port         = 0
        to_port           = 65535
      },
      {
        protocol       = "ANY"
        description    = "Rule allows all outgoing traffic. Nodes can connect to Yandex Container Registry, Yandex Object Storage, Docker Hub, and so on."
        v4_cidr_blocks = ["0.0.0.0/0"]
        from_port      = 0
        to_port        = 65535
      }
      ]
      labels = {
        security-group = "name-your-security-group-2"
      }
    }
    name-your-security-groups-3 = {
      description              = "Created by Terraform"
      network_name             = "name-your-network-1"
      firewall_ingress_rules = [
      {
        protocol          = "TCP"
        description       = "access to api k8s from Yandex lb"
        predefined_target = "loadbalancer_healthchecks"
        from_port         = 0
        to_port           = 65535
      },
      {
        protocol       = "TCP"
        description    = "access to api k8s"
        v4_cidr_blocks = ["0.0.0.0/0"]
        port           = 443
      }
      ]
      labels = {
        security-group = "name-your-security-group-3"
      }
    }
    name-your-security-groups-4 = {
      description              = "Created by Terraform"
      network_name             = "name-your-network-1"
      firewall_ingress_rules = [
      {
        protocol       = "ANY"
        description    = "any connections"
        v4_cidr_blocks = ["0.0.0.0/0"]
        from_port      = 0
        to_port        = 65535
      }
      ]
      firewall_egress_rules = [{
        protocol       = "ANY"
        description    = "any connections"
        v4_cidr_blocks = ["0.0.0.0/0"]
        from_port      = 0
        to_port        = 65535
      }
      ]
      labels = {
        security-group = "name-your-security-group-4"
      }
    }
  }
}

### ========= OUTPUTS ========== ###

output "network_names" {
  value = module.vpc.network_names
}

output "network_ids" {
  value = module.vpc.network_ids
}

output "subnet_names" {
  value = module.vpc.subnet_names
}

output "subnet_ids" {
  value = module.vpc.subnet_ids
}

output "external_ips_names" {
  value = module.vpc.external_ips_names
}

output "sg_names" {
  value = module.vpc.sg_names
}

output "sg_ids" {
  value = module.vpc.sg_ids
}
