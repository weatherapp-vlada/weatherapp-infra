variable "name" {
  type = string
}

variable "repository_url" {
  type = string
}

variable "github_access_token" {
  type      = string
  sensitive = true
}

variable "backend_base_url" {
  type = string
}

variable "frontend_base_url" {
  type = string
}

variable "cognito_issuer_uri" {
  type = string
}

variable "cognito_client_secret" {
  type      = string
  sensitive = true
}

variable "cognito_client_id" {
  type = string
}

variable "domain_name" {
  type = string
}

variable "branch_name" {
  type = string
}

variable "secrets" {
  type = string
}

variable "zone_name" {
  type = string
}

variable "cognito_user_pool_id" {
  type = string
}
