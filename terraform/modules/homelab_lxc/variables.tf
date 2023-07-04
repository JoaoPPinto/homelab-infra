variable "lxc_name" {
  description = "LXC Container Name (Automatically appended the suffix -lxc)"
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

variable "os_template" {
  description = "Base LXC"
  type = string
}

variable "on_boot" {
  type = bool
  default = false
}

variable "unprivileged" {
  type = bool
  default = true
}

variable "docker_syscalls" {
  type = bool
  default = true
}

variable "core_count" {
  description = "LXC Core Count"
  type = number
  default = 1
}

variable "memory" {
  description = "LXC Memory"
  type = number
  default = 512
}

variable "ipconfig" {
  description = "LXC IP Config"
  type = object({
    ip = string
    gateway = string
    cidr = string
  })
}

variable "rootfs" {
  description = "LXC RootFS Config"
  type = object({
    storage = string
    size = string
  })
}


variable "ssh_keys" {
  type = string
}