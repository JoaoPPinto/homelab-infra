resource "proxmox_vm_qemu" "vm_qemu" {
  count = 1
  name = "${var.vm_name}-vm"

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
      network,
      desc
    ]
  }
}


resource "pihole_dns_record" "vm_main_dns_record" {
  provider = pihole.main
  domain  = "${var.vm_name}.${var.domain}"
  ip      = "${var.ipconfig.ip}"
}

resource "pihole_dns_record" "vm_backup_dns_record" {
  provider = pihole.backup
  domain  = "${var.vm_name}.${var.domain}"
  ip      = "${var.ipconfig.ip}"
}