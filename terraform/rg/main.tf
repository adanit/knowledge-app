# Criar o Resource Group para o projeto
resource "azurerm_resource_group" "rg-block" {
  name     = var.rg_name
  location = var.rg_location
}