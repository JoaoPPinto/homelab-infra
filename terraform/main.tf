module "budget_vm" {
  source = "./modules/homelab_vm"
  vm_name = "budget"
  domain = var.base_domain
  target_node = var.default_pve_node
  vm_template = "debian-11-template"
  memory = 1024
  disk_config = [ {
    size = "7G"
    storage = "local-lvm"
    type = "scsi"
  } ]
  network_config = [ {
    bridge = "vmbr0"
    model = "virtio"
  } ]
  ipconfig = {
    ip = "192.168.1.25"
    gateway = "192.168.1.1"
    cidr = "24"
  }

  providers = {
    pihole.main = pihole
    pihole.backup = pihole.zero
  }
}

module "dashboard_vm" {
  source = "./modules/homelab_vm"
  vm_name = "dashboard"
  domain = var.base_domain
  target_node = var.default_pve_node
  vm_template = "debian-11-template"
  memory = 512
  disk_config = [ {
    size = "5G"
    storage = "local-lvm"
    type = "scsi"
  } ]
  network_config = [ {
    bridge = "vmbr0"
    model = "virtio"
  } ]
  ipconfig = {
    ip = "192.168.1.30"
    gateway = "192.168.1.1"
    cidr = "24"
  }

  providers = {
    pihole.main = pihole
    pihole.backup = pihole.zero
  }
}