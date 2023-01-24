# Ubuntu Server Focal Docker
# ---
# Packer Template to create an Ubuntu Server (Focal) with Docker on Proxmox

variable "proxmox_user" {
    type = string
}

variable "proxmox_password" {
    type = string
    sensitive = true
}

source "proxmox" "ubuntu-server-2204" {
 
    proxmox_url = "https://192.168.1.50:8006/api2/json"
    username = "${var.proxmox_user}"
    password = "${var.proxmox_password}"
    insecure_skip_tls_verify = true
    
    node = "arsenal"
    vm_id = "9003"
    vm_name = "ubuntu-2204-template"
    template_description = "Ubuntu Server 22.04 Image"

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

    boot_command = [
        "c<wait>",
        "linux /casper/vmlinuz --- autoinstall ds='nocloud-net;s=http://{{ .HTTPIP }}:{{ .HTTPPort }}/'",
        "<enter><wait5>",
        "initrd /casper/initrd",
        "<enter><wait>",
        "boot",
        "<enter>",
        "<enter><f10><wait>"
    ]
    boot_wait = "5s"

    http_directory = "http" 

    ssh_username = "admin"
    ssh_password = "334PF9YD"
    ssh_timeout = "20m"
}

build {
    name = "ubuntu-server-2204"
    sources = ["source.proxmox.ubuntu-server-2204"]

    provisioner "shell" {
        inline = [
            "while [ ! -f /var/lib/cloud/instance/boot-finished ]; do echo 'Waiting for cloud-init...'; sleep 1; done",
        ]
    }

    provisioner "shell" {
        inline = [
            "mkdir /tmp/provisioning",
            "chmod 777 /tmp/provisioning"
        ]
    }

    provisioner "shell" {
        execute_command = "chmod +x {{ .Path }}; {{ .Vars }} sudo {{ .Path }}"
        script = "./scripts/motd.sh"
    }
}
