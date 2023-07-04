variable "vm_name" {
  description = "VM Name (Automatically appended the suffix -vm)"
  type = string
}

variable "domain" {
  description = "Domain to create the DNS Records on"
  type = string
}

variable "target_node" {
  description = "Target Proxmox Node"
  type = string
}

variable "vm_template" {
  description = "Base VM"
  type = string
}

variable "start_vm" {
  description = "Start VM after creation"
  type = bool
  default = true
}

variable "on_boot" {
  type = bool
  default = false
}

variable "core_count" {
  description = "VM Core Count"
  type = number
  default = 1
}

variable "memory" {
  description = "VM Memory"
  type = number
  default = 512
}

variable "disk_config" {
  description = "VM Disks"
  type = list(object({
    size = string
    storage = string
    type = string
  }))
}

variable "network_config" {
  description = "VM NICs"
  type = list(object({
    model = string
    bridge = string
  }))
}

variable "ipconfig" {
  description = "VM IP Config"
  type = object({
    ip = string
    gateway = string
    cidr = string
  })
}


