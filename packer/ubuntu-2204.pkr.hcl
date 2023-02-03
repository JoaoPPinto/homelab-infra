# Ubuntu Server Focal Docker
# ---
# Packer Template to create an Ubuntu Server (Focal) on Proxmox

variable "proxmox_user" {
    type = string
}

variable "proxmox_auth_realm" {
    type = string
}

variable "proxmox_password" {
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

variable "ssh_user" {
    type = string
}

variable "ssh_password" {
    type = string
    sensitive = true
}

source "proxmox" "ubuntu-server-2204" {
 
    proxmox_url = "https://${var.proxmox_url}:8006/api2/json"
    username = "${var.proxmox_user}@${var.proxmox_auth_realm}"
    password = "${var.proxmox_password}"
    insecure_skip_tls_verify = false
    
    node = "${var.proxmox_node}"
    vm_id = "${var.template_id}"
    vm_name = "ubuntu-2204-template"
    template_description = "Ubuntu Server 22.04 Image Template"

    iso_file = "local:iso/ubuntu-22.04.1-live-server-amd64.iso"
    unmount_iso = true

    qemu_agent = true
    scsi_controller = "virtio-scsi-pci"
    disks {
        disk_size = "5G"
        storage_pool = "local-lvm"
        storage_pool_type = "lvm"
        type = "scsi"
    }
    cores = "1"
    memory = "2048" 
    network_adapters {
        model = "virtio"
        bridge = "vmbr0"
        firewall = "false"
    } 

#"linux /casper/vmlinuz --- autoinstall ds='nocloud-net;s=http://{{ .HTTPIP }}:{{ .HTTPPort }}/'<enter><wait><wait>initrd /casper/initrd<enter><wait10>",
    boot_command = [
        "c<wait>",
        "linux /casper/vmlinuz --- autoinstall ds=nocloud-net;s=/cidata/",
        "<enter><wait><wait>",
        "initrd /casper/initrd",
        "<enter><wait10>",
        "boot",
        "<enter>"
    ]
    boot_wait = "10s"

    cloud_init = "true"
    cloud_init_storage_pool = "local-lvm"

   # http_directory = "http" 
    additional_iso_files {
        cd_files = [
            "./http/meta-data",
            "./http/user-data"
        ]
        cd_label         = "cidata"
        iso_storage_pool = "local"
    }

    ssh_username = "${var.ssh_user}"
    ssh_password = "${var.ssh_password}"
    ssh_timeout = "20m"
}

build {
    name = "ubuntu-server-2204"
    sources = ["source.proxmox.ubuntu-server-2204"]

    provisioner "shell" {
        inline = [
            "while [ ! -f /var/lib/cloud/instance/boot-finished ]; do echo 'Waiting for cloud-init...'; sleep 1; done",
            "sudo rm /etc/ssh/ssh_host_*",
            "sudo truncate -s 0 /etc/machine-id",
            "sudo apt-get -y clean",
            "sudo cloud-init clean",
            "sudo rm -f /etc/cloud/cloud.cfg.d/subiquity-disable-cloudinit-networking.cfg",
            "sudo sync"
        ]
    }

    provisioner "shell" {
        inline = [
            "mkdir /tmp/provisioning",
            "chmod 777 /tmp/provisioning"
        ]
    }

    provisioner "file" {
        source      = "files/99-pve.cfg"
        destination = "/tmp/provisioning/99-pve.cfg"
    }

    provisioner "shell" {
        inline = ["sudo cp /tmp/provisioning/99-pve.cfg /etc/cloud/cloud.cfg.d/99-pve.cfg"]
    }

    provisioner "shell" {
        execute_command = "chmod +x {{ .Path }}; {{ .Vars }} sudo {{ .Path }}"
        script = "./scripts/motd.sh"
    }

    provisioner "shell" {
        execute_command = "chmod +x {{ .Path }}; {{ .Vars }} sudo {{ .Path }}"
        script = "./scripts/sshd.sh"
    }

    post-processor "shell-local" {
        environment_vars = [
            "SSH_PASSWORD=${var.proxmox_password}",
            "SSH_USER=${var.proxmox_user}",
            "SSH_HOST=${var.proxmox_url}",
            "VM_ID=${var.template_id}"
        ]
        inline = [
            "sshpass -p $SSH_PASSWORD ssh $SSH_USER@$SSH_HOST qm set $VM_ID --delete ide3"
        ]
    }
}
