module "firefly_vm" {
  source = "./modules/homelab_vm"
  vm_name = "firefly"
  domain = var.base_domain
  target_node = var.default_pve_node
  vm_template = "debian-11-template"
  memory = 768
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