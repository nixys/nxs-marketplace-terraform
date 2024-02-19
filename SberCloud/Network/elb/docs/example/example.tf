provider "sbercloud" {
  auth_url = "https://iam.ru-moscow-1.hc.sbercloud.ru/v3"
  region   = "ru-moscow-1"
}
terraform {
  backend "s3" {
    bucket   = "name-your-bucket"
    key      = "name_your_tfstate_for_elb.tfstate"
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

module "elb" {
  source = "github.com/nixys/nxs-marketplace-terraform/SberCloud/Network/elb"

  general_project_id = data.terraform_remote_state.projects.outputs.project_ids["name_your_project_1"] # Default project
  general_region     = "ru-moscow-1"                                                                   # Default region

  loadbalancer = {
#    dedicated-name-your-elb-1 = {
#      elb_type              = "dedicated"
#      enterprise_project_id = data.terraform_remote_state.projects.outputs.project_ids["name_your_project_1"]
#      region                = "ru-moscow-1"
#      description           = "Created by Terraform"
#      availability_zone     = ["ru-moscow-1a", "ru-moscow-1c", "ru-moscow-1e"]
#      cross_vpc_backend     = true
#      vpc_id                = data.terraform_remote_state.vpc.outputs.vpc_ids["name_your_vpc_2"]
#      ipv4_subnet_id        = data.terraform_remote_state.vpc.outputs.subnet_ipv4_ids["name_your_subnet_5"]
#      ipv6_network_id       = data.terraform_remote_state.vpc.outputs.subnet_ids["name_your_subnet_5"]
#      ipv6_bandwidth_id     = ""
#      ipv4_address          = "192.168.2.3"
#      ipv4_eip_id           = data.terraform_remote_state.vpc.outputs.eip_ids["name_your_eip_3"]
#      iptype                = "5_bgp"
#      bandwidth_charge_mode = "traffic"
#      sharetype             = "PER"
#      bandwidth_size        = 10
#      type                  = "L7"
#      max_connections       = 200000
#      cps                   = 2000
#      bandwidth             = 50
#      auto_renew            = true
#      autoscaling_enabled   = false
#      min_l7_flavor_id      = "HTTP"
#      
#      tags = {
#        created_by = "terraform"
#      }
#    }
    shared-name-your-elb-1 = {
      elb_type              = "shared"
      enterprise_project_id = data.terraform_remote_state.projects.outputs.project_ids["name_your_project_1"]
      region                = "ru-moscow-1"
      description           = "Created by Terraform"
      vip_subnet_id         = data.terraform_remote_state.vpc.outputs.subnet_ipv4_ids["name_your_subnet_5"]
      vip_address           = "192.168.2.3"
      
      tags = {
        created_by = "terraform"
      }
    }
  }

  certificate = {
#    dedicated-name-your-certificate-1 = {
#      elb_type              = "dedicated"
#      region                = "ru-moscow-1"
#      description           = "Created by Terraform"
#      enterprise_project_id = data.terraform_remote_state.projects.outputs.project_ids["name_your_project_1"]    
#      type                  = "server"
#      certificate = <<-EOT
#      -----BEGIN CERTIFICATE-----
#      MIIDpTCCAo2gAwIBAgIJAKdmmOBYnFvoMA0GCSqGSIb3DQEBCwUAMGkxCzAJBgNV
#      BAYTAnh4MQswCQYDVQQIDAJ4eDELMAkGA1UEBwwCeHgxCzAJBgNVBAoMAnh4MQsw
#      CQYDVQQLDAJ4eDELMAkGA1UEAwwCeHgxGTAXBgkqhkiG9w0BCQEWCnh4QDE2My5j
#      b20wHhcNMTcxMjA0MDM0MjQ5WhcNMjAxMjAzMDM0MjQ5WjBpMQswCQYDVQQGEwJ4
#      eDELMAkGA1UECAwCeHgxCzAJBgNVBAcMAnh4MQswCQYDVQQKDAJ4eDELMAkGA1UE
#      CwwCeHgxCzAJBgNVBAMMAnh4MRkwFwYJKoZIhvcNAQkBFgp4eEAxNjMuY29tMIIB
#      IjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAwZ5UJULAjWr7p6FVwGRQRjFN
#      2s8tZ/6LC3X82fajpVsYqF1xqEuUDndDXVD09E4u83MS6HO6a3bIVQDp6/klnYld
#      iE6Vp8HH5BSKaCWKVg8lGWg1UM9wZFnlryi14KgmpIFmcu9nA8yV/6MZAe6RSDmb
#      3iyNBmiZ8aZhGw2pI1YwR+15MVqFFGB+7ExkziROi7L8CFCyCezK2/oOOvQsH1dz
#      Q8z1JXWdg8/9Zx7Ktvgwu5PQM3cJtSHX6iBPOkMU8Z8TugLlTqQXKZOEgwajwvQ5
#      mf2DPkVgM08XAgaLJcLigwD513koAdtJd5v+9irw+5LAuO3JclqwTvwy7u/YwwID
#      AQABo1AwTjAdBgNVHQ4EFgQUo5A2tIu+bcUfvGTD7wmEkhXKFjcwHwYDVR0jBBgw
#      FoAUo5A2tIu+bcUfvGTD7wmEkhXKFjcwDAYDVR0TBAUwAwEB/zANBgkqhkiG9w0B
#      AQsFAAOCAQEAWJ2rS6Mvlqk3GfEpboezx2J3X7l1z8Sxoqg6ntwB+rezvK3mc9H0
#      83qcVeUcoH+0A0lSHyFN4FvRQL6X1hEheHarYwJK4agb231vb5erasuGO463eYEG
#      r4SfTuOm7SyiV2xxbaBKrXJtpBp4WLL/s+LF+nklKjaOxkmxUX0sM4CTA7uFJypY
#      c8Tdr8lDDNqoUtMD8BrUCJi+7lmMXRcC3Qi3oZJW76ja+kZA5mKVFPd1ATih8TbA
#      i34R7EQDtFeiSvBdeKRsPp8c0KT8H1B4lXNkkCQs2WX5p4lm99+ZtLD4glw8x6Ic
#      i1YhgnQbn5E0hz55OLu5jvOkKQjPCW+8Kg==
#      -----END CERTIFICATE-----
#      EOT
#
#      private_key = <<-EOT
#      -----BEGIN RSA PRIVATE KEY-----
#      MIIEowIBAAKCAQEAwZ5UJULAjWr7p6FVwGRQRjFN2s8tZ/6LC3X82fajpVsYqF1x
#      qEuUDndDXVD09E4u83MS6HO6a3bIVQDp6/klnYldiE6Vp8HH5BSKaCWKVg8lGWg1
#      UM9wZFnlryi14KgmpIFmcu9nA8yV/6MZAe6RSDmb3iyNBmiZ8aZhGw2pI1YwR+15
#      MVqFFGB+7ExkziROi7L8CFCyCezK2/oOOvQsH1dzQ8z1JXWdg8/9Zx7Ktvgwu5PQ
#      M3cJtSHX6iBPOkMU8Z8TugLlTqQXKZOEgwajwvQ5mf2DPkVgM08XAgaLJcLigwD5
#      13koAdtJd5v+9irw+5LAuO3JclqwTvwy7u/YwwIDAQABAoIBACU9S5fjD9/jTMXA
#      DRs08A+gGgZUxLn0xk+NAPX3LyB1tfdkCaFB8BccLzO6h3KZuwQOBPv6jkdvEDbx
#      Nwyw3eA/9GJsIvKiHc0rejdvyPymaw9I8MA7NbXHaJrY7KpqDQyk6sx+aUTcy5jg
#      iMXLWdwXYHhJ/1HVOo603oZyiS6HZeYU089NDUcX+1SJi3e5Ke0gPVXEqCq1O11/
#      rh24bMxnwZo4PKBWdcMBN5Zf/4ij9vrZE+fFzW7vGBO48A5lvZxWU2U5t/OZQRtN
#      1uLOHmMFa0FIF2aWbTVfwdUWAFsvAOkHj9VV8BXOUwKOUuEktdkfAlvrxmsFrO/H
#      yDeYYPkCgYEA/S55CBbR0sMXpSZ56uRn8JHApZJhgkgvYr+FqDlJq/e92nAzf01P
#      RoEBUajwrnf1ycevN/SDfbtWzq2XJGqhWdJmtpO16b7KBsC6BdRcH6dnOYh31jgA
#      vABMIP3wzI4zSVTyxRE8LDuboytF1mSCeV5tHYPQTZNwrplDnLQhywcCgYEAw8Yc
#      Uk/eiFr3hfH/ZohMfV5p82Qp7DNIGRzw8YtVG/3+vNXrAXW1VhugNhQY6L+zLtJC
#      aKn84ooup0m3YCg0hvINqJuvzfsuzQgtjTXyaE0cEwsjUusOmiuj09vVx/3U7siK
#      Hdjd2ICPCvQ6Q8tdi8jV320gMs05AtaBkZdsiWUCgYEAtLw4Kk4f+xTKDFsrLUNf
#      75wcqhWVBiwBp7yQ7UX4EYsJPKZcHMRTk0EEcAbpyaJZE3I44vjp5ReXIHNLMfPs
#      uvI34J4Rfot0LN3n7cFrAi2+wpNo+MOBwrNzpRmijGP2uKKrq4JiMjFbKV/6utGF
#      Up7VxfwS904JYpqGaZctiIECgYA1A6nZtF0riY6ry/uAdXpZHL8ONNqRZtWoT0kD
#      79otSVu5ISiRbaGcXsDExC52oKrSDAgFtbqQUiEOFg09UcXfoR6HwRkba2CiDwve
#      yHQLQI5Qrdxz8Mk0gIrNrSM4FAmcW9vi9z4kCbQyoC5C+4gqeUlJRpDIkQBWP2Y4
#      2ct/bQKBgHv8qCsQTZphOxc31BJPa2xVhuv18cEU3XLUrVfUZ/1f43JhLp7gynS2
#      ep++LKUi9D0VGXY8bqvfJjbECoCeu85vl8NpCXwe/LoVoIn+7KaVIZMwqoGMfgNl
#      nEqm7HWkNxHhf8A6En/IjleuddS1sf9e/x+TJN1Xhnt9W6pe7Fk1
#      -----END RSA PRIVATE KEY-----
#      EOT
#
#      domain                = "www.elb.com"
#    }
    shared-name-your-certificate-1 = {
      elb_type              = "shared"
      region                = "ru-moscow-1"
      description           = "Created by Terraform"
      enterprise_project_id = data.terraform_remote_state.projects.outputs.project_ids["name_your_project_1"]    
      type                  = "server"
      certificate = <<-EOT
      -----BEGIN CERTIFICATE-----
      MIIDpTCCAo2gAwIBAgIJAKdmmOBYnFvoMA0GCSqGSIb3DQEBCwUAMGkxCzAJBgNV
      BAYTAnh4MQswCQYDVQQIDAJ4eDELMAkGA1UEBwwCeHgxCzAJBgNVBAoMAnh4MQsw
      CQYDVQQLDAJ4eDELMAkGA1UEAwwCeHgxGTAXBgkqhkiG9w0BCQEWCnh4QDE2My5j
      b20wHhcNMTcxMjA0MDM0MjQ5WhcNMjAxMjAzMDM0MjQ5WjBpMQswCQYDVQQGEwJ4
      eDELMAkGA1UECAwCeHgxCzAJBgNVBAcMAnh4MQswCQYDVQQKDAJ4eDELMAkGA1UE
      CwwCeHgxCzAJBgNVBAMMAnh4MRkwFwYJKoZIhvcNAQkBFgp4eEAxNjMuY29tMIIB
      IjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAwZ5UJULAjWr7p6FVwGRQRjFN
      2s8tZ/6LC3X82fajpVsYqF1xqEuUDndDXVD09E4u83MS6HO6a3bIVQDp6/klnYld
      iE6Vp8HH5BSKaCWKVg8lGWg1UM9wZFnlryi14KgmpIFmcu9nA8yV/6MZAe6RSDmb
      3iyNBmiZ8aZhGw2pI1YwR+15MVqFFGB+7ExkziROi7L8CFCyCezK2/oOOvQsH1dz
      Q8z1JXWdg8/9Zx7Ktvgwu5PQM3cJtSHX6iBPOkMU8Z8TugLlTqQXKZOEgwajwvQ5
      mf2DPkVgM08XAgaLJcLigwD513koAdtJd5v+9irw+5LAuO3JclqwTvwy7u/YwwID
      AQABo1AwTjAdBgNVHQ4EFgQUo5A2tIu+bcUfvGTD7wmEkhXKFjcwHwYDVR0jBBgw
      FoAUo5A2tIu+bcUfvGTD7wmEkhXKFjcwDAYDVR0TBAUwAwEB/zANBgkqhkiG9w0B
      AQsFAAOCAQEAWJ2rS6Mvlqk3GfEpboezx2J3X7l1z8Sxoqg6ntwB+rezvK3mc9H0
      83qcVeUcoH+0A0lSHyFN4FvRQL6X1hEheHarYwJK4agb231vb5erasuGO463eYEG
      r4SfTuOm7SyiV2xxbaBKrXJtpBp4WLL/s+LF+nklKjaOxkmxUX0sM4CTA7uFJypY
      c8Tdr8lDDNqoUtMD8BrUCJi+7lmMXRcC3Qi3oZJW76ja+kZA5mKVFPd1ATih8TbA
      i34R7EQDtFeiSvBdeKRsPp8c0KT8H1B4lXNkkCQs2WX5p4lm99+ZtLD4glw8x6Ic
      i1YhgnQbn5E0hz55OLu5jvOkKQjPCW+8Kg==
      -----END CERTIFICATE-----
      EOT

      private_key = <<-EOT
      -----BEGIN RSA PRIVATE KEY-----
      MIIEowIBAAKCAQEAwZ5UJULAjWr7p6FVwGRQRjFN2s8tZ/6LC3X82fajpVsYqF1x
      qEuUDndDXVD09E4u83MS6HO6a3bIVQDp6/klnYldiE6Vp8HH5BSKaCWKVg8lGWg1
      UM9wZFnlryi14KgmpIFmcu9nA8yV/6MZAe6RSDmb3iyNBmiZ8aZhGw2pI1YwR+15
      MVqFFGB+7ExkziROi7L8CFCyCezK2/oOOvQsH1dzQ8z1JXWdg8/9Zx7Ktvgwu5PQ
      M3cJtSHX6iBPOkMU8Z8TugLlTqQXKZOEgwajwvQ5mf2DPkVgM08XAgaLJcLigwD5
      13koAdtJd5v+9irw+5LAuO3JclqwTvwy7u/YwwIDAQABAoIBACU9S5fjD9/jTMXA
      DRs08A+gGgZUxLn0xk+NAPX3LyB1tfdkCaFB8BccLzO6h3KZuwQOBPv6jkdvEDbx
      Nwyw3eA/9GJsIvKiHc0rejdvyPymaw9I8MA7NbXHaJrY7KpqDQyk6sx+aUTcy5jg
      iMXLWdwXYHhJ/1HVOo603oZyiS6HZeYU089NDUcX+1SJi3e5Ke0gPVXEqCq1O11/
      rh24bMxnwZo4PKBWdcMBN5Zf/4ij9vrZE+fFzW7vGBO48A5lvZxWU2U5t/OZQRtN
      1uLOHmMFa0FIF2aWbTVfwdUWAFsvAOkHj9VV8BXOUwKOUuEktdkfAlvrxmsFrO/H
      yDeYYPkCgYEA/S55CBbR0sMXpSZ56uRn8JHApZJhgkgvYr+FqDlJq/e92nAzf01P
      RoEBUajwrnf1ycevN/SDfbtWzq2XJGqhWdJmtpO16b7KBsC6BdRcH6dnOYh31jgA
      vABMIP3wzI4zSVTyxRE8LDuboytF1mSCeV5tHYPQTZNwrplDnLQhywcCgYEAw8Yc
      Uk/eiFr3hfH/ZohMfV5p82Qp7DNIGRzw8YtVG/3+vNXrAXW1VhugNhQY6L+zLtJC
      aKn84ooup0m3YCg0hvINqJuvzfsuzQgtjTXyaE0cEwsjUusOmiuj09vVx/3U7siK
      Hdjd2ICPCvQ6Q8tdi8jV320gMs05AtaBkZdsiWUCgYEAtLw4Kk4f+xTKDFsrLUNf
      75wcqhWVBiwBp7yQ7UX4EYsJPKZcHMRTk0EEcAbpyaJZE3I44vjp5ReXIHNLMfPs
      uvI34J4Rfot0LN3n7cFrAi2+wpNo+MOBwrNzpRmijGP2uKKrq4JiMjFbKV/6utGF
      Up7VxfwS904JYpqGaZctiIECgYA1A6nZtF0riY6ry/uAdXpZHL8ONNqRZtWoT0kD
      79otSVu5ISiRbaGcXsDExC52oKrSDAgFtbqQUiEOFg09UcXfoR6HwRkba2CiDwve
      yHQLQI5Qrdxz8Mk0gIrNrSM4FAmcW9vi9z4kCbQyoC5C+4gqeUlJRpDIkQBWP2Y4
      2ct/bQKBgHv8qCsQTZphOxc31BJPa2xVhuv18cEU3XLUrVfUZ/1f43JhLp7gynS2
      ep++LKUi9D0VGXY8bqvfJjbECoCeu85vl8NpCXwe/LoVoIn+7KaVIZMwqoGMfgNl
      nEqm7HWkNxHhf8A6En/IjleuddS1sf9e/x+TJN1Xhnt9W6pe7Fk1
      -----END RSA PRIVATE KEY-----
      EOT

      domain                = "www.1elb.com"
    }
  }

## Only dedicated ELB

  ipgroup = {
#    dedicated-name-your-ipgroup-1 = {
#      elb_type              = "dedicated"
#      region                = "ru-moscow-1"
#      description           = "Created by Terraform"
#      enterprise_project_id = data.terraform_remote_state.projects.outputs.project_ids["name_your_project_1"]
#      
#      ip_list = [{
#        ip          = "192.168.10.10/32"
#        description = "Created by Terraform"
#       }
#      ]
#    }
  }
  
## Only shared ELB

  whitelist = {
    shared-name-your-whitelist-1 = {
      elb_type              = "shared"
      region                = "ru-moscow-1"
      enable_whitelist      = true
      whitelist             = "192.168.11.1,192.168.0.1/24,192.168.201.18/8"
      listener_name         = "shared-name-your-listener-1"
    }
  }

  listener = {
#    dedicated-name-your-listener-1 = {
#      elb_type                    = "dedicated"
#      loadbalancer_name           = "dedicated-name-your-elb-1"
#      region                      = "ru-moscow-1"
#      description                 = "Created by Terraform"
#      protocol                    = "HTTP"
#      protocol_port               = 8080
#      default_pool_id             = ""
#      http2_enable                = false
#      forward_eip                 = false
#      access_policy               = "white"
#      ipgroup_name                = "dedicated-name-your-ipgroup-1"
#      server_certificate_name     = "dedicated-name-your-certificate-1"
#      sni_certificate_name        = ["dedicated-name-your-certificate-1", "dedicated-name-your-certificate-2"]
#      ca_certificate_name         = ""
#      tls_ciphers_policy          = ""
#      idle_timeout                = 10
#      request_timeout             = 60
#      response_timeout            = 60
#      advanced_forwarding_enabled = false
#
#      tags = {
#        created_by = "terraform"
#      }
#    }
    shared-name-your-listener-1 = {
      elb_type                    = "shared"
      loadbalancer_name           = "shared-name-your-elb-1"
      region                      = "ru-moscow-1"
      description                 = "Created by Terraform"
      protocol                    = "HTTP"
      protocol_port               = 8080
      default_pool_id             = ""
      connection_limit            = -1
      http2_enable                = false
      default_tls_container_ref   = "shared-name-your-certificate-1"
      sni_container_refs          = ["shared-name-your-certificate-1", "shared-name-your-certificate-2"]

      tags = {
        created_by = "terraform"
      }
    }
  }

  pool = {
#    dedicated-name-your-pool-1 = {
#      elb_type              = "dedicated"
#      loadbalancer_name     = "dedicated-name-your-elb-1"
#      region                = "ru-moscow-1"
#      description           = "Created by Terraform"
#      protocol              = "HTTP"
#      listener_name         = "dedicated-name-your-listener-1"
#      lb_method             = "ROUND_ROBIN"
#     
#      persistence = [{
#        type        = "HTTP_COOKIE"
#        cookie_name = "testcookie"
#        timeout     = 60
#      },
#     ]
#    }
    shared-name-your-pool-1 = {
      elb_type              = "shared"
      loadbalancer_name     = "shared-name-your-elb-1"
      region                = "ru-moscow-1"
      description           = "Created by Terraform"
      protocol              = "HTTP"
      listener_name         = ""
      lb_method             = "ROUND_ROBIN"
     
      persistence = [{
        type        = "HTTP_COOKIE"
        cookie_name = "testcookie"
        timeout     = 60
      },
     ]
    }
  }

  member = {
#    dedicated-name-your-member-1 = {
#      elb_type                    = "dedicated"
#      region                      = "ru-moscow-1"
#      pool_name                   = "dedicated-name-your-pool-1"
#      subnet_id                   = data.terraform_remote_state.vpc.outputs.subnet_ipv4_ids["name_your_subnet_5"]
#      address                     = "192.168.2.3"
#      protocol_port               = 8080
#      weight                      = 1
#    }
    shared-name-your-member-1 = {
      elb_type                    = "shared"
      region                      = "ru-moscow-1"
      pool_name                   = "shared-name-your-pool-1"
      subnet_id                   = data.terraform_remote_state.vpc.outputs.subnet_ipv4_ids["name_your_subnet_5"]
      address                     = "192.168.2.3"
      protocol_port               = 8080
      weight                      = 1
    }
  }

  monitor = {
#    dedicated-name-your-member-1 = {
#      elb_type              = "dedicated"
#      region                      = "ru-moscow-1"
#      pool_name                   = "dedicated-name-your-pool-1"
#      protocol                    = "HTTP"
#      interval                    = 50
#      timeout                     = 49
#      max_retries                 = 10
#      url_path                    = "/bb"
#      domain_name                 = "www.bb.com"
#      port                        = 8888
#      status_code                 = "200,301,404-500,504"
#    }
    shared-name-your-member-1 = {
      elb_type                    = "shared"
      region                      = "ru-moscow-1"
      pool_name                   = "shared-name-your-pool-1"
      type                        = "HTTP"
      delay                       = 50
      timeout                     = 49
      max_retries                 = 10
      url_path                    = "/bb"
      http_method                 = "GET"
      port                        = 8888
      expected_codes              = "200,301,404-500,504"
    }
  }

  l7policy = {
#    dedicated-name-your-l7policy-1 = {
#      elb_type              = "dedicated"
#      region                      = "ru-moscow-1"
#      description                 = "Created by Terraform"
#      listener_name               = "dedicated-name-your-listener-1"
#      pool_name                   = "dedicated-name-your-pool-1"
#    }
    shared-name-your-l7policy-1 = {
      elb_type                    = "shared"
      region                      = "ru-moscow-1"
      description                 = "Created by Terraform"
      listener_name               = "shared-name-your-listener-1"
      pool_name                   = "shared-name-your-pool-1"
      need_redirect_http_to_https = false
      listener_https_name         = "shared-name-your-listener-2"
      position                    = 1
    }
  }

  l7policy_rule = {
#    dedicated-name-your-l7policy-rule-1 = {
#      elb_type              = "dedicated"
#      region                      = "ru-moscow-1"
#      l7policy_name               = "dedicated-name-your-l7policy-1"
#      type                        = "PATH"
#      compare_type                = "EQUAL_TO"
#      value                       = "/api"
#    }
    shared-name-your-l7policy-rule-1 = {
      elb_type                    = "shared"
      region                      = "ru-moscow-1"
      l7policy_name               = "shared-name-your-l7policy-1"
      type                        = "PATH"
      compare_type                = "EQUAL_TO"
      value                       = "/api"
      key                         = "testCookie"
    }
  }
}

