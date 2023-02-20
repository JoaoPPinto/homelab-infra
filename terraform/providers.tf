terraform {
  required_providers {
    proxmox = {
      source = "telmate/proxmox"
      version = "2.9.11"
    }
    pihole = {
      source = "ryanwholey/pihole"
      version = "0.0.12"
    }
  }
}

provider "proxmox" {
  pm_api_url = "https://arsenal.pve.fatska.xyz:8006/api2/json"
}

provider "pihole" {
  url = "https://pihole.ocelot.fatska.xyz"
  api_token = var.ocelot_api_token
}

provider "pihole" {
  alias = "zero"
  url = "https://pihole.zero.fatska.xyz"
  api_token = var.zero_api_token
}