variable "base_domain" {
  description = "DNS Base domain for the environment"
  type = string
}

variable "default_pve_node" {
  description = "Default Proxmox Node"
  type = string
}

variable "ocelot_api_token" {
  type = string
}

variable "zero_api_token" {
  type = string
}