terraform {
  required_providers {
    proxmox = {
      source = "telmate/proxmox"
      version = "~>2.9.11"
    }
  }
}

resource "proxmox_vm_qemu" "vm_qemu" {
  count = 1
  name = "${var.vm_name}"

  target_node = "${var.target_node}"
  clone = "${var.vm_template}"
  full_clone = "true"
  oncreate = "${var.start_vm}"

  agent = 1
  cores = "${var.core_count}"
  sockets = 1
  cpu = "host"
  memory = "${var.memory}"
  qemu_os = "l26"
  os_type = "cloud-init"
  scsihw = "virtio-scsi-pci"
  bootdisk = "scsi0"
  tablet = false

  dynamic "disk" {
    for_each = var.disk_config
    content {
      size = disk.value.size
      storage = disk.value.storage
      type = disk.value.type
    }
  }

  dynamic "network" {
    for_each = var.network_config
    content {
      model = network.value.model
      bridge = network.value.bridge
      firewall = false
    }
  }

  ipconfig0 = "ip=${var.ipconfig.ip}/${var.ipconfig.cidr},gw=${var.ipconfig.gateway}"

  lifecycle {
    ignore_changes = [
      network
    ]
  }
}
