output "vms" {
  value = [
    module.budget_vm.vm_name
  ]
}

output "vm_dns" {
  value = {
    (module.budget_vm.vm_name) = module.budget_vm.dns
  }
}

output "vm_ips" {
  value = {
    (module.budget_vm.vm_name) = module.budget_vm.vm_ip
  }
}