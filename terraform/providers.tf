terraform {
  required_providers {
    proxmox = {
      source = "telmate/proxmox"
      version = "2.9.11"
    }
  }
}

provider "proxmox" {
  pm_api_url = "https://arsenal.pve.fatska.xyz:8006/api2/json"
  pm_user = "root@pam"
  pm_password = "admin"
}