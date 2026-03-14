# Module Naming
module "naming" {
  source  = "Azure/naming/azurerm"
  version = "0.4.2"
  suffix  = ["labinfo", "prod", "eus2", "002"]
}

# Modulo Resource Group
module "rg-module" {
  source      = "./rg"
  rg_name     = module.naming.resource_group.name
  rg_location = var.rg_location
}

# Modulo Container Registry
module "acr-module" {
  source      = "./containerregistry"
  cr_name     = module.naming.container_registry.name
  rg_name     = module.rg-module.rg_name
  cr_location = module.rg-module.rg_location
  cr_sku      = var.cr_sku
}

# Modulo Container Group
module "acg-module" {
  source              = "./containergroup"
  acg_name            = module.naming.container_group.name
  rg_name             = module.rg-module.rg_name
  acg_location        = module.rg-module.rg_location
  acg_ip_address_type = var.acg_ip_address_type
  acg_dns_name_label  = var.acg_dns_name_label
  acg_os_type         = var.acg_os_type

  acr_login_server = module.acr-module.cr_login_server
  acr_username     = module.acr-module.cr_admin_username
  acr_password     = module.acr-module.cr_admin_password

  ct_frontend_name     = "knowledge-app-frontend"
  ct_frontend_image    = "${module.acr-module.cr_login_server}/kbapp-frontend:latest"
  ct_frontend_cpu      = var.ct_frontend_cpu
  ct_frontend_memory   = var.ct_frontend_memory
  api_url              = var.api_url
  ct_frontend_port     = var.ct_frontend_port
  ct_frontend_protocol = var.ct_frontend_protocol


  ct_backend_name     = "knowledge-app-backend"
  ct_backend_image    = "${module.acr-module.cr_login_server}/kbapp-backend:latest"
  ct_backend_cpu      = var.ct_backend_cpu
  ct_backend_memory   = var.ct_backend_memory
  database_url        = var.database_url
  redis_url           = var.redis_url
  ct_backend_port     = var.ct_backend_port
  ct_backend_protocol = var.ct_backend_protocol

  ct_postgres_name     = "postgres"
  ct_postgres_image    = "docker.io/postgres:15"
  ct_postgres_cpu      = var.ct_postgres_cpu
  ct_postgres_memory   = var.ct_postgres_memory
  postgres_db          = var.postgres_db
  postgres_user        = var.postgres_user
  postgres_password    = var.postgres_password
  ct_postgres_port     = var.ct_postgres_port
  ct_postgres_protocol = var.ct_postgres_protocol


  ct_redis_name   = "redis"
  ct_redis_image  = "docker.io/redis:7"
  ct_redis_cpu    = var.ct_redis_cpu
  ct_redis_memory = var.ct_redis_memory
}

