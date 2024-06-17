terraform {
  required_providers {
    proxmox = {
      source = "telmate/proxmox"
      version = "3.0.1-rc3"
    }
    pihole = {
      source = "ryanwholey/pihole"
      version = "0.2.0"
    }
  }
}

provider "proxmox" {
  pm_api_url = "https://arsenal.pve.fatska.xyz:8006/api2/json"
}

provider "pihole" {
  alias = "ocelot"
  url = "https://pihole.ocelot.fatska.xyz"
  api_token = var.ocelot_api_token
}

provider "pihole" {
  alias = "zero"
  url = "https://pihole.zero.fatska.xyz"
  api_token = var.zero_api_token
}
