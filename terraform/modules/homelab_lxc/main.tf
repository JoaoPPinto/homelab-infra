resource "proxmox_lxc" "lxc" {
  hostname = "${var.lxc_name}-lxc"
  
  unprivileged = "${var.unprivileged}"

  target_node = "${var.target_node}"
  ostemplate = "${var.os_template}"
  onboot = "${var.on_boot}"

  ssh_public_keys = "${var.ssh_keys}"

  features {
    #fuse = "${var.docker_syscalls}"
    #keyctl = "${var.docker_syscalls}"
    nesting = "${var.docker_syscalls}"
  }

  cores = "${var.core_count}"
  memory = "${var.memory}"

  rootfs {
    storage = "${var.rootfs.storage}"
    size = "${var.rootfs.size}"
  }

  network {
    name = "eth0"
    bridge = "vmbr0"
    ip = "${var.ipconfig.ip}/${var.ipconfig.cidr}"
    gw = "${var.ipconfig.gateway}"
  }

  lifecycle {
    ignore_changes = [ 
      features
     ]
  }

}

resource "pihole_dns_record" "lxc_main_dns_record" {
  provider = pihole.main
  domain  = "${var.lxc_name}.vm.${var.domain}"
  ip      = "${var.ipconfig.ip}"
}

resource "pihole_dns_record" "lxc_backup_dns_record" {
  provider = pihole.backup
  domain  = "${var.lxc_name}.vm.${var.domain}"
  ip      = "${var.ipconfig.ip}"
}