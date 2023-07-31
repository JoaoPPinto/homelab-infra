# Debian 12 Bookworm
# ---
# Packer Template to create a base Debian 12 VM on Proxmox

source "proxmox-iso" "debian-12" {
 
  proxmox_url = "https://${var.proxmox_url}:8006/api2/json"
  username = "${var.proxmox_user}@${var.proxmox_auth_realm}!${var.proxmox_token_name}"
  token = "${var.proxmox_token}"
  insecure_skip_tls_verify = false
  node = var.proxmox_node

  vm_id = var.template_id
  vm_name = "template-debian-12"
  template_description = "Debian 12 Bookworm Image Template -- Created: ${formatdate("YYYY-MM-DD hh:mm:ss ZZZ", timestamp())}"

  iso_file = "local:iso/debian-12.0.0-amd64-netinst.iso"
  unmount_iso = true

  qemu_agent = true
  os = "l26"
  cores = "1"
  cpu_type = "host"
  memory = "2048"
  scsi_controller = "virtio-scsi-pci"
  bios  = "seabios"
  cloud_init = "true"
  cloud_init_storage_pool = "local-lvm"

  disks {
    disk_size = "4G"
    storage_pool = "local-lvm"
    type = "scsi"
  }

  network_adapters {
    model = "virtio"
    bridge = "vmbr0"
    firewall = "false"
  } 

  boot_command = [
    "<esc><wait>auto url=http://{{ .HTTPIP }}:{{ .HTTPPort }}/preseed.cfg<enter>"
  ]
  boot_wait = "10s"
  http_directory = "http"

  ssh_username = "root"
  ssh_password = "packer"
  ssh_timeout = "20m"
}

build {
  name = "debian-12"
  sources = ["source.proxmox-iso.debian-12"]

  # Cloud-Init configurations files
  provisioner "file" {
    source      = "files/99-pve.cfg"
    destination = "/etc/cloud/cloud.cfg.d/99-pve.cfg"
  }

  provisioner "file" {
    source      = "files/cloud.cfg"
    destination = "/etc/cloud/cloud.cfg"
  }

  # Provision the machine
  # TODO: create ansible playbook
  provisioner "shell" {
    environment_vars = ["DEBIAN_FRONTEND=noninteractive"]
    inline = [
      "sudo apt-get -y install bash-completion curl htop net-tools python3 python3-pip vim wget",
      "sudo apt -y autoremove --purge",
      "sudo apt-get clean",
      "apt -y autoclean",
      "sync"
    ]
  }

  # Cleanup step, ensure Cloud-Init runs on next boot
  provisioner "shell" {
    inline = [
      "rm /etc/ssh/ssh_host_*",
      "rm -f /var/lib/systemd/random-seed",
      "truncate -s 0 /etc/machine-id",
      "truncate -s 0 /etc/machine-info",
      "truncate -s 0 /var/lib/dbus/machine-id",
      "journalctl --rotate",
      "rm -rf /var/log/*.gz",
      "cloud-init clean",
      "sync"
    ]
  }
 
}
