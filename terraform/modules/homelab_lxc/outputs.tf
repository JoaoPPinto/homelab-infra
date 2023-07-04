output "lxc_name" {
    value = var.lxc_name
}

output "dns" {
    value = pihole_dns_record.lxc_main_dns_record.domain
}

output "lxc_ip" {
  value = var.ipconfig.ip
}