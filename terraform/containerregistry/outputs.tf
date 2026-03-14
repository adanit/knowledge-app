output "cr_name" {
  value = azurerm_container_registry.acr.name
}

output "cr_login_server" {
  value = azurerm_container_registry.acr.login_server
  sensitive = true
}

output "cr_admin_username" {
  value = azurerm_container_registry.acr.admin_username
  sensitive = true
}

output "cr_admin_password" {
  value = azurerm_container_registry.acr.admin_password
  sensitive = true
}
