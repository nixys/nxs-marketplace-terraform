
resource "sbercloud_compute_keypair" "keypair" {
  for_each   = var.keypair
  name       = each.key
  key_file   = try(each.value.key_file, null)
  public_key = try(each.value.public_key, null)
  region     = try(each.value.region, "ru-moscow-1")
}