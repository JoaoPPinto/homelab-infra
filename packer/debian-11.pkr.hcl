# Ubuntu Server Focal Docker
# ---
# Packer Template to create an Ubuntu Server (Focal) on Proxmox

variable "proxmox_user" {
  type = string
}

variable "proxmox_auth_realm" {
  type = string
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

source "proxmox" "debian-11" {
 
  proxmox_url = "https://${var.proxmox_url}:8006/api2/json"
  username = "${var.proxmox_user}@${var.proxmox_auth_realm}!${var.proxmox_token_name}"
  token = "${var.proxmox_token}"
  insecure_skip_tls_verify = false

  node = "${var.proxmox_node}"
  vm_id = "${var.template_id}"
  vm_name = "debian-11-template"
  template_description = "Debian 11 Bullseye Image Template"

  iso_file = "local:iso/debian-11.6.0-amd64-netinst.iso"
  unmount_iso = true

  qemu_agent = true
  os = "l26"
  scsi_controller = "virtio-scsi-pci"
  disks {
    disk_size = "5G"
    storage_pool = "local-lvm"
    storage_pool_type = "lvm"
    type = "scsi"
  }
  cores = "1"
  cpu_type = "host"
  memory = "2048" 
  network_adapters {
    model = "virtio"
    bridge = "vmbr0"
    firewall = "false"
  } 

  boot_command = [
    "<esc><wait>auto url=http://{{ .HTTPIP }}:{{ .HTTPPort }}/preseed.cfg<enter>"
  ]
  boot_wait = "10s"

  cloud_init = "true"
  cloud_init_storage_pool = "local-lvm"

  http_directory = "http" 
  #additional_iso_files {
  #  cd_files = [
  #      "./http/meta-data",
  #      "./http/user-data"
  #  ]
  #  cd_label         = "cidata"
  #  iso_storage_pool = "local"
  #}

  ssh_username = "root"
  ssh_password = "packer"
  ssh_timeout = "20m"
}

build {
  name = "debian-11"
  sources = ["source.proxmox.debian-11"]

  provisioner "shell" {
    environment_vars = ["DEBIAN_FRONTEND=non-interactive"]
    inline = [
      "sudo apt-get -y install bash-completion curl htop net-tools python3 python3-pip vim wget",
      "sudo apt -y autoremove --purge",
      "sudo apt-get clean",
      "sync"
    ]
  }

  provisioner "file" {
    source      = "files/99-pve.cfg"
    destination = "/etc/cloud/cloud.cfg.d/99-pve.cfg"
  }

  provisioner "file" {
    source      = "files/cloud.cfg"
    destination = "/etc/cloud/cloud.cfg"
  }

  provisioner "shell" {
    script = "./scripts/motd.sh"
  }

  provisioner "shell" {
    inline = [
      "rm -f /var/lib/systemd/random-seed",
      "truncate -s 0 /etc/machine-id",
      "truncate -s 0 /etc/machine-info",
      "truncate -s 0 /var/lib/dbus/machine-id",
      "journalctl --rotate",
      "rm -rf /var/log/*.gz",
      "sync"
    ]
  }
 
}
