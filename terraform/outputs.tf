output "vms" {
  value = [
    module.budget_vm.vm_name,
    module.dashboard_vm.vm_name
  ]
}

output "vm_dns" {
  value = {
    (module.budget_vm.vm_name) = module.budget_vm.dns,
    (module.dashboard_vm.vm_name) = module.dashboard_vm.dns
  }
}

output "vm_ips" {
  value = {
    (module.budget_vm.vm_name) = module.budget_vm.vm_ip,
    (module.dashboard_vm.vm_name) = module.dashboard_vm.vm_ip
  }
}