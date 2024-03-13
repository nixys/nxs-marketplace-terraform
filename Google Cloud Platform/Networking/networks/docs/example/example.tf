provider "google" {
  credentials   = file("project-credentials.json")
  project       = YOUR_PROJECT_ID
  region        = YOUR_REGION
}
terraform {
  backend "gcs" {
    bucket      = "name-your-bucket-1"
    prefix      = "terraform/networks/networks/state"
    credentials = "project-credentials.json"
  }
}

module "vpc" {
  source = "github.com/nixys/nxs-marketplace-terraform/Google Cloud Platform/Networking/networks"

  networks = {
    name-your-network-1 = {
      description             = "Created by Terraform"
      auto_create_subnetworks = true
      mtu                     = 1460
    }
  }

  subnetworks = {
    name-your-subnetwork-1 = {
      description   = "Created by Terraform"
      ip_cidr_range = "10.3.0.0/24"
      network_name  = "name-your-network-1"
      secondary_ip_range = [
      {
        range_name    = "k8s-services"
        ip_cidr_range = "192.168.10.0/24"
      },
      {
        range_name    = "k8s-pods"
        ip_cidr_range = "192.168.20.0/24"
      }
      ]
      log_config = [{
        aggregation_interval = "INTERVAL_10_MIN"
        flow_sampling        = 0.5
        metadata             = "INCLUDE_ALL_METADATA"
      }]
      private_ip_google_access = true
    }
    name-your-subnetwork-2 = {
      description             = "Created by Terraform"
      ip_cidr_range           = "10.4.0.0/24"
      network_name            = "name-your-network-1"
      log_config = [{
        aggregation_interval = "INTERVAL_10_MIN"
        flow_sampling        = 0.5
        metadata             = "INCLUDE_ALL_METADATA"
      }]
      private_ip_google_access = true
    }
  }

  routers = {
    name-your-router-1 = {
      description = "Created by Terraform"
      network     = "name-your-network-1"
      bgp = [{
        asn = 64514
      }]
    }
  }

  static_ips = {
    name-your-static-ip-1 = {
      description  = "Created by Terraform"
      address_type = "EXTERNAL"
    }
    name-your-static-ip-2 = {
      description  = "Created by Terraform"
      address_type = "EXTERNAL"
    }
  }

  router_nats = {
    name-your-router-nat-1 = {
      router                             = "name-your-router-1"
      nat_ip_allocate_option             = "MANUAL_ONLY"
      nat_ips                            = ["name-your-static-ip-1"]
      source_subnetwork_ip_ranges_to_nat = "LIST_OF_SUBNETWORKS"
      subnetwork = [{
        name                    = "name-your-subnetwork-1"
        source_ip_ranges_to_nat = ["ALL_IP_RANGES"]
      }]
    }
  }

  firewalls = {
    name-your-firewall-1 = {
      description        = "Created by Terraform"
      network            = "name-your-network-1"
      direction          = "INGRESS"
      destination_ranges = ["10.3.0.0/24"]
      allow = [{
        protocol = "tcp"
        ports    = ["22"]
      }]
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