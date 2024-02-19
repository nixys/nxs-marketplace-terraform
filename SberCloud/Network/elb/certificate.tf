## Create Dedicate ELB certificate
resource "sbercloud_elb_certificate" "certificate" {
  for_each = { for k, v in var.certificate : k => v if v.elb_type == "dedicated" }

  name                        = each.key
  region                      = try(each.value.region, var.general_region)
  description                 = try(each.value.description, "Created by Terraform")
  enterprise_project_id       = try(each.value.project_id, var.general_project_id)
  type                        = try(each.value.type, "server")
  certificate                 = each.value.certificate
  private_key                 = each.value.type == "server" ? each.value.private_key : null
  domain                      = each.value.type == "server" ? each.value.domain : null

}

## Create Shared ELB certificate
resource "sbercloud_lb_certificate" "certificate" {
  for_each = { for k, v in var.certificate : k => v if v.elb_type == "shared" }

  name                        = each.key
  region                      = try(each.value.region, var.general_region)
  description                 = try(each.value.description, "Created by Terraform")
  enterprise_project_id       = try(each.value.project_id, var.general_project_id)
  type                        = try(each.value.type, "server")
  certificate                 = each.value.certificate
  private_key                 = each.value.type == "server" ? each.value.private_key : null
  domain                      = each.value.type == "server" ? each.value.domain : null

}