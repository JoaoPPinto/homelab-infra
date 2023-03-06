output "vms" {
  value = [
    module.firefly_vm.vm_name
  ]
}

output "vm_dns" {
  value = {
    (module.firefly_vm.vm_name) = module.firefly_vm.dns
  }
}

output "vm_ips" {
  value = {
    (module.firefly_vm.vm_name) = module.firefly_vm.vm_ip
  }
}