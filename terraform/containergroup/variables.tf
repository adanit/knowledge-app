variable "acg_name" {
  description = "Nome do Container Group"
  type        = string
}

variable "acg_location" {
  description = "Localização do Container Group"
  type        = string
}

variable "rg_name" {
  description = "Nome do Resource Group"
  type        = string
}

variable "acg_ip_address_type" {
  description = "Tipo de IP do Container Group"
  type        = string
}

variable "acg_dns_name_label" {
  description = "Rótulo de DNS do Container Group"
  type        = string
}

variable "acg_os_type" {
  description = "Tipo de SO do Container Group"
  type        = string
}

variable "acr_login_server" {
  description = "Login server do Container Registry"
  type        = string
}

variable "acr_username" {
  description = "Usuário admin do Container Registry"
  type        = string
  sensitive   = true
}

variable "acr_password" {
  description = "Senha admin do Container Registry"
  type        = string
  sensitive   = true
}

variable "ct_frontend_name" {
  description = "Nome do Container Frontend"
  type        = string
}

variable "ct_frontend_image" {
  description = "Imagem do Container Frontend"
  type        = string
}

variable "ct_frontend_cpu" {
  description = "CPU do Container Frontend"
  type        = number
}

variable "ct_frontend_memory" {
  description = "Memória do Container Frontend"
  type        = number
}

variable "api_url" {
  description = "URL do Backend"
  type        = string
}

variable "ct_frontend_port" {
  description = "Porta do Container Frontend"
  type        = number
}

variable "ct_frontend_protocol" {
  description = "Protocolo do Container Frontend"
  type        = string
}

variable "ct_backend_name" {
  description = "Nome do Container Backend"
  type        = string
}

variable "ct_backend_image" {
  description = "Imagem do Container Backend"
  type        = string
}

variable "ct_backend_cpu" {
  description = "CPU do Container Backend"
  type        = number
}

variable "ct_backend_memory" {
  description = "Memória do Container Backend"
  type        = number
}

variable "ct_backend_port" {
  description = "Porta do Container Backend"
  type        = number
}

variable "ct_backend_protocol" {
  description = "Protocolo do Container Backend"
  type        = string
}

variable "ct_postgres_name" {
  description = "Nome do Container PostgreSQL"
  type        = string
}

variable "ct_postgres_image" {
  description = "Imagem do Container PostgreSQL"
  type        = string
}

variable "ct_postgres_cpu" {
  description = "CPU do Container PostgreSQL"
  type        = number
}

variable "ct_postgres_memory" {
  description = "Memória do Container PostgreSQL"
  type        = number
}

variable "ct_postgres_port" {
  description = "Porta do Container PostgreSQL"
  type        = number
}

variable "ct_postgres_protocol" {
  description = "Protocolo do Container PostgreSQL"
  type        = string
}

variable "database_url" {
  description = "Variável de ambiente para a url do banco de dados"
  type = string
}

variable "redis_url" {
  description = "Variável de ambiente para a url do Redis"
  type = string
}

variable "postgres_db" {
  description = "Nome do banco de dados PostgreSQL"
  type        = string
}

variable "postgres_user" {
  description = "Usuário do banco de dados PostgreSQL"
  type        = string
}

variable "postgres_password" {
  description = "Senha do banco de dados PostgreSQL"
  type        = string
}

variable "ct_redis_name" {
  description = "Nome do Container Redis"
  type        = string
}

variable "ct_redis_image" {
  description = "Imagem do Container Redis"
  type        = string
}

variable "ct_redis_cpu" {
  description = "CPU do Container Redis"
  type        = number
}

variable "ct_redis_memory" {
  description = "Memória do Container Redis"
  type        = number
}