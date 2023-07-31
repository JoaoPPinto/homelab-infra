variable "proxmox_user" {
  type = string
}

variable "proxmox_auth_realm" {
  type    = string
  default = "pve"
}

variable "proxmox_token_name" {
  type = string
}

variable "proxmox_token" {
  type = string
  sensitive = true
}

variable "proxmox_url" {
  type = string
}

variable "proxmox_node" {
  type = string
}

variable "template_id" {
  type = string
}