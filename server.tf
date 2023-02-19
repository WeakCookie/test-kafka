resource "digitalocean_ssh_key" "default" {
  name       = "Terraform Example"
  public_key = file("./ssh/test-kafka-do.pub")
}

resource "digitalocean_droplet" "kafka" {
  image  = "ubuntu-20-04-x64"
  name   = "kafka-hieu"
  region = "sgp1"
  size   = "s-4vcpu-8gb"
  ssh_keys = [digitalocean_ssh_key.default.fingerprint]
}