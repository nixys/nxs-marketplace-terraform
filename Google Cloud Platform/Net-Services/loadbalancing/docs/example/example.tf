provider "google" {
  credentials   = file("project-credentials.json")
  project       = YOUR_PROJECT_ID
  region        = YOUR_REGION
}
terraform {
  backend "gcs" {
    bucket      = "name-your-bucket-1"
    prefix      = "terraform/net-service/loadbalancer/state"
    credentials = "project-credentials.json"
  }
}

module "loadbalancing" {
  source = "github.com/nixys/nxs-marketplace-terraform/Google Cloud Platform/Net-Services/loadbalancing"

  targets_grpc_proxy = {
    name-your-target-grpc-proxy-1 = {
      description            = "Created by Terraform"
      url_map                = "name-your-url-map-1"
      validate_for_proxyless = true
    }
  }

  targets_http_proxy = {
    name-your-target-http-proxy-1 = {
      description            = "Created by Terraform"
      url_map                = "name-your-url-map-1"
      validate_for_proxyless = true
    } 
  }

  #targets_https_proxy = {
  #  name-your-target-https-proxy-1 = {
  #    description                  = "Created by Terraform"
  #    url_map                      = "name-your-url-map-1"
  #    http_keep_alive_timeout_sec  = 610
  #  } 
  #}

  #targets_ssl_proxy = {
  #  name-your-target-ssl-proxy-1 = {
  #    description                  = "Created by Terraform"
  #    proxy_header                 = "PROXY_V1"
  #    backend_service              = "name-your-backend-service-4"
  #  } 
  #}

  targets_tcp_proxy = {
    name-your-target-tcp-proxy-1 = {
      description                  = "Created by Terraform"
      backend_service              = "name-your-backend-service-3"
    } 
  }

  region_targets_http_proxy = {
    name-your-region-target-http-proxy-1 = {
      description                  = "Created by Terraform"
      url_map                      = "name-your-region-url-map-1"
      validate_for_proxyless       = true
    } 
  }

  region_backend_services = {
    name-your-region-backend-service-1 = {
      protocol              = "HTTP"
      health_checks         = ["name-your-region-health-checks-1"]
      load_balancing_scheme = "INTERNAL_MANAGED"
    }
  }

  region_health_checks = {
    name-your-region-health-checks-1 = {
      timeout_sec        = 1
      check_interval_sec = 1

      tcp_health_check = [{
        port = "80"
      }]
    }
  }

  health_checks = {
    name-your-health-checks-1 = {
      timeout_sec        = 1
      check_interval_sec = 1

      tcp_health_check = [{
        port = "80"
      }]
    }
  }
  
  backend_services = {
    name-your-backend-service-1 = {
      protocol              = "HTTP"
      health_checks         = ["name-your-health-checks-1"]
      load_balancing_scheme = "EXTERNAL"
    }
    name-your-backend-service-2 = {
      protocol              = "HTTPS"
      health_checks         = ["name-your-health-checks-1"]
      load_balancing_scheme = "EXTERNAL"
    }
    name-your-backend-service-3 = {
      protocol              = "TCP"
      health_checks         = ["name-your-health-checks-1"]
      load_balancing_scheme = "EXTERNAL"
    }
    name-your-backend-service-4 = {
      protocol              = "SSL"
      health_checks         = ["name-your-health-checks-1"]
      load_balancing_scheme = "EXTERNAL"
    }
    name-your-backend-service-5 = {
      protocol              = "GRPC"
      health_checks         = ["name-your-health-checks-1"]
      load_balancing_scheme = "INTERNAL_SELF_MANAGED"
    }
  }

  forwarding_rules = {
    name-your-forwarding-rules-1 = {
      target_http           = "name-your-region-target-http-proxy-1"
      load_balancing_scheme = "INTERNAL_MANAGED"
      port_range            = "80"
      region                = "us-west1"
      subnetwork            = "terraform1"
      network               = "terraform"
    }
  }

  url_maps = {
    name-your-url-map-1 = {
      default_service = "name-your-backend-service-1"
      host_rule = [{
        hosts        = ["mysite.com"]
        path_matcher = "mysite"
      },
      {
        hosts        = ["myothersite.com"]
        path_matcher = "otherpaths"
      }
      ]
      path_matcher = [{
        name            = "mysite"
        default_service = "name-your-backend-service-1"
        path_rule = [{
          paths   = ["/home"]
          service = "name-your-backend-service-1"
        },
        {
          paths   = ["/login"]
          service = "name-your-backend-service-1"
        }
        ]
      },
      {
        name            = "otherpaths"
        default_service = "name-your-backend-service-1"
      }
      ]
      test = [{
        service = "name-your-backend-service-1"
        host    = "example.com"
        path    = "/home"
      }]
    }
  }

  region_url_maps = {
    name-your-region-url-map-1 = {
      default_service = "name-your-region-backend-service-1"
      region          = "us-west1"
      host_rule = [{
        hosts        = ["mysite.com"]
        path_matcher = "mysite"
      },
      {
        hosts        = ["myothersite.com"]
        path_matcher = "otherpaths"
      }
      ]
      path_matcher = [{
        name            = "mysite"
        default_service = "name-your-region-backend-service-1"
        path_rule = [{
          paths   = ["/home"]
          service = "name-your-region-backend-service-1"
        },
        {
          paths   = ["/login"]
          service = "name-your-region-backend-service-1"
        }
        ]
      },
      {
        name            = "otherpaths"
        default_service = "name-your-region-backend-service-1"
      }
      ]
      test = [{
        service = "name-your-region-backend-service-1"
        host    = "example.com"
        path    = "/home"
      }]
    }
  }

}
