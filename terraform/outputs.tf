output "rg-name" {
  value = module.naming.resource_group
}

output "rg-location" {
  value = module.rg-module.rg_location
}

output "cr_name" {
  value = module.acr-module.cr_name
}

output "cr_login_server" {
  value     = module.acr-module.cr_login_server
  sensitive = true
}

output "cr_admin_username" {
  value     = module.acr-module.cr_admin_username
  sensitive = true
}

output "cr_admin_password" {
  value     = module.acr-module.cr_admin_password
  sensitive = true
}

output "app_url" {
  value = "http://${var.acg_dns_name_label}.eastus2.azurecontainer.io:3000"
}
