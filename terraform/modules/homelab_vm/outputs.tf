output "vm_name" {
    value = var.vm_name
}

output "dns" {
    value = pihole_dns_record.vm_record.domain
}

output "vm_ip" {
  value = var.ipconfig.ip
}