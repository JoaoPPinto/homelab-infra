module "auth-vm" {
  source = "./modules/homelab_vm"
  vm_name = "auth-vm"
  target_node = "arsenal"
  vm_template = "debian-11-template"
  memory = 512
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
    ip = "192.168.1.72"
    gateway = "192.168.1.1"
    cidr = "24"
  }
}