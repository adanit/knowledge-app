# Settings Block
# Forneça a chave via variável de ambiente: ARM_ACCESS_KEY=<sua_chave>
# ou usando: terraform init -backend-config="access_key=<sua_chave>"
terraform {
  backend "azurerm" {
    resource_group_name  = "rg-labinfo-prod-eus2-001"
    storage_account_name = "strterraformbackend001"
    container_name       = "backend-terraform"
    key                  = "terraform-cilab.tfstate"
    # access_key é lido da variável de ambiente ARM_ACCESS_KEY
  }
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">=4.50.0"
    }

    random = {
      source  = "hashicorp/random"
      version = ">=3.0.0"
    }
  }
}