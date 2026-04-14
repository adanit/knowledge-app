variable "subscription_id" {
  description = "ID da Subscrição do Azure"
  type        = string
}

variable "client_id" {
  description = "ID do Cliente (Client ID) do Azure"
  type        = string
}

variable "client_secret" {
  description = "Segredo do Cliente (Client Secret) do Azure"
  type        = string
}

variable "tenant_id" {
  description = "ID do Inquilino (Tenant ID) do Azure"
  type        = string
}

variable "rg_location" {
  description = "Localização do Resource Group"
  type        = string
}

variable "cr_sku" {
  description = "SKU do Container Registry"
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

variable "frontend_nr_license_key" {
  description = "Chave de licença do New Relic para o Container Frontend"
  type        = string
  sensitive   = true
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

variable "database_url" {
  description = "Variável de ambiente para a url do banco de dados"
  type        = string
}

variable "redis_url" {
  description = "Variável de ambiente para a url do Redis"
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

variable "ct_postgres_port" {
  description = "Porta do Container PostgreSQL"
  type        = number
}

variable "ct_postgres_protocol" {
  description = "Protocolo do Container PostgreSQL"
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