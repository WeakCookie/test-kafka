resource "digitalocean_ssh_key" "default" {
  name       = "Terraform Example"
  public_key = var.public_ssh_key
}

resource "digitalocean_droplet" "kafka" {
  image  = "ubuntu-20-04-x64"
  name   = "kafka-hieu"
  region = "sgp1"
  size   = "s-4vcpu-8gb"
  ssh_keys = [digitalocean_ssh_key.default.fingerprint]
}