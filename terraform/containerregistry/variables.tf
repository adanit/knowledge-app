variable "cr_name" {
  description = "Nome do Container Registry"
  type        = string
}

variable "rg_name" {
  description = "Nome do Grupo de recursos"
  type        = string
}


variable "cr_location" {
  description = "Localização do Container Registry"
  type        = string
}

variable "cr_sku" {
  description = "SKU do Container Registry"
  type        = string
}
