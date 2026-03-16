resource "azurerm_container_group" "acg" {
  name                = var.acg_name
  location            = var.acg_location
  resource_group_name = var.rg_name
  ip_address_type     = "Public"
  dns_name_label      = var.acg_dns_name_label
  os_type             = "Linux"

  image_registry_credential {
    server   = var.acr_login_server
    username = var.acr_username
    password = var.acr_password
  }

  container {
    name   = var.ct_frontend_name
    image  = var.ct_frontend_image
    cpu    = var.ct_frontend_cpu
    memory = var.ct_frontend_memory
    environment_variables = {
      API_URL= var.api_url
      NEW_RELIC_APP_NAME = "kbapp-frontend"
      NEW_RELIC_LICENSE_KEY = "25cc108181a49b1682b75cb3906c7d29FFFFNRAL"
    }

    ports {
      port     = var.ct_frontend_port
      protocol = var.ct_frontend_protocol
    }
  }

  container {
    name   = var.ct_backend_name
    image  = var.ct_backend_image
    cpu    = var.ct_backend_cpu
    memory = var.ct_backend_memory
    environment_variables = {
      BACKEND_URL = var.database_url
      REDIS_URL   = var.redis_url
    }

      ports {
      port     = var.ct_backend_port
      protocol = var.ct_backend_protocol
    }

  }

  container {
    name   = var.ct_postgres_name
    image  = var.ct_postgres_image
    cpu    = var.ct_postgres_cpu
    memory = var.ct_postgres_memory
    environment_variables = {
      POSTGRES_DB       = var.postgres_db
      POSTGRES_USER     = var.postgres_user
      POSTGRES_PASSWORD = var.postgres_password
    }

      ports {
      port     = var.ct_postgres_port
      protocol = var.ct_postgres_protocol
    }
  }

    container {
    name   = var.ct_redis_name
    image  = var.ct_redis_image
    cpu    = var.ct_redis_cpu
    memory = var.ct_redis_memory
  }
}