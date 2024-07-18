provider "google" {
  credentials = file("project-credentials.json")
  project     = YOUR_PROJECT_ID
  region      = YOUR_REGION
}

terraform {
  backend "gcs" {
    bucket      = "name-your-bucket-1"
    prefix      = "terraform/memorystore/redis/state"
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

module "redis" {
  source = "github.com/nixys/nxs-marketplace-terraform/Google Cloud Platform/Memorystore/redis"

  redis = {
    ha-memory-cache-persis = {
      is_cluster              = false
      memory_size_gb          = 5
      location_id             = "us-central1-a"
      alternative_location_id = "us-central1-f"
      display_name            = "Redis HA persistent"
      tier                    = "STANDARD_HA"

      persistence_config = [{
        persistence_mode        = "RDB"
        rdb_snapshot_period     = "TWENTY_FOUR_HOURS"
        rdb_snapshot_start_time = "2024-01-01T00:00:00Z"
      }]

      maintenance_policy = [{
        description = "Base maintenance policy"
        weekly_maintenance_window = [{
          day = "SATURDAY"
          start_time = [{
            hours = 4
          }]
        }]
      }]
    }

    memory-cache-nonpersis = {
      is_cluster = false

      memory_size_gb = 2
      location_id    = "us-central1-a"
      display_name   = "Redis non-HA non-persistent"
      tier           = "BASIC"
      redis_version  = "REDIS_7_0"
      labels = {
        system = "redis"
      }

      persistence_config = [{
        persistence_mode = "DISABLED"
      }]
    }

    redis-cluster-ha = {
      is_cluster = true

      shard_count = 3

      psc_configs = [{
        network = data.terraform_remote_state.vpc.outputs.vpc_ids["redis-cluster-network"]
      }]

      transit_encryption_mode = "TRANSIT_ENCRYPTION_MODE_DISABLED"
      node_type               = "REDIS_SHARED_CORE_NANO"
      replica_count           = 0
    }
  }
}
