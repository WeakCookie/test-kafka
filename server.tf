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
  user_data = <<-EOF
		#!/bin/bash
    # CREATE SWAP
    sudo fallocate -l 4G /swapfile
    sudo chmod 600 /swapfile
    sudo mkswap /swapfile
    sudo swapon /swapfile
    sudo cat /etc/fstab >> /swapfile swap swap defaults 0 0

    # INSTALL DOCKER
    curl -fsSL https://get.docker.com -o get-docker.sh
    sudo sh get-docker.sh

    # INSTALL DOCKER COMPOSE
    sudo curl -L "https://github.com/docker/compose/releases/download/1.29.1/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
    sudo chmod +x /usr/local/bin/docker-compose
    sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose

    # INSTALL Git
    sudo apt install git
  EOF
}