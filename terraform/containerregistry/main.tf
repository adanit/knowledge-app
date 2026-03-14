resource "azurerm_container_registry" "acr" {
  name                = var.cr_name
  resource_group_name = var.rg_name
  location            = var.cr_location
  sku                 = var.cr_sku
  admin_enabled       = true
  georeplications {
    location                = "East US"
  }
}