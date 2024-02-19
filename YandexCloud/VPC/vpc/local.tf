locals {
  default_egress_rules = {
    protocol       = "ANY"
    description    = "allow all"
    v4_cidr_blocks = ["0.0.0.0/0"]
    port           = -1
  }
}