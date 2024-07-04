provider "google" {
  credentials   = file("project-credentials.json")
  project       = YOUR_PROJECT_ID
  region        = YOUR_REGION
}
terraform {
  backend "gcs" {
    bucket      = "name-your-bucket-1"
    prefix      = "terraform/gke/gke/state"
    credentials = "project-credentials.json"
  }
}

data "terraform_remote_state" "vpc" {
  backend = "gcs"

  config = {
    bucket      = "name-your-bucket-1"
    prefix      = "terraform/networks/networks/state"
    credentials = "project-credentials.json"
  }
}

module "gke" {
  source = "github.com/nixys/nxs-marketplace-terraform/Google Cloud Platform/Kubernetes/kubernetes"

  clusters = {
    name-your-cluster-1 = {
      deletion_protection = false

      enable_http_load_balancing        = true
      enable_horizontal_pod_autoscaling = true

      cluster_autoscaling_enabled = false
      default_max_pods_per_node   = 110
      initial_node_count          = 1
      services_range_name         = "k8s-services"
      pods_range_name             = "k8s-pods"

      master_authorized_networks_config = [
        {
          cidr_block   = data.terraform_remote_state.vpc.outputs.subnet_cidrs["name-your-subnetwork-1"]
          display_name = "VPC"
        }
      ]

      min_master_version              = "1.28.3-gke.1118000"
      network                         = "name-your-network-1"
      enable_private_nodes            = true
      enable_private_endpoint         = true
      master_ipv4_cidr_block          = "172.22.1.0/28"
      channel                         = "UNSPECIFIED"
      remove_default_node_pool        = true
      enable_vertical_pod_autoscaling = true
      subnetwork                      = "name-your-subnetwork-1"
      timeout_create                  = "30m"
      timeout_update                  = "30m"
      timeout_delete                  = "30m"

    }
  }

  node_pools = {
    name-your-node-pool-1 = {
      cluster                     = "name-your-cluster-1"
      location                    = "us-west1"
      initial_node_count_per_zone = 1
      auto_repair                 = true
      auto_upgrade                = false
      max_pods_per_node           = 110
      node_locations              = ["us-west1-a", "us-west1-b", "us-west1-c"]

      disk_size_gb = 50
      disk_type    = "pd-standard"
      machine_type = "custom-4-8192"
      oauth_scopes = ["https://www.googleapis.com/auth/logging.write", "https://www.googleapis.com/auth/monitoring"]

      upgrade_max_surge       = 1
      upgrade_max_unavailable = 0
    }

    name-your-node-pool-2 = {
      cluster                     = "name-your-cluster-1"
      location                    = "us-west1"
      initial_node_count_per_zone = 1
      auto_repair                 = true
      auto_upgrade                = false
      max_pods_per_node           = 110
      node_locations              = ["us-west1-a", "us-west1-b", "us-west1-c"]

      disk_size_gb = 50
      disk_type    = "pd-standard"
      machine_type = "custom-4-8192"
      oauth_scopes = ["https://www.googleapis.com/auth/logging.write", "https://www.googleapis.com/auth/monitoring"]

      labels = {
        kind = "name-your-node-pool-2"
      }
      taints = [
        {
          effect = "NO_SCHEDULE",
          key    = "kind",
          value  = "name-your-node-pool-2",
        },
      ]

      upgrade_max_surge       = 1
      upgrade_max_unavailable = 0
    }
  }

}