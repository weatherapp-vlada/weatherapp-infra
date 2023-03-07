variable "region" {
  type = string
  default = "eu-central-1"
}

variable "pool_name" {
  type = string
}

variable "lambda_name" {
  type = string
}

variable "frontend_base_url" {
  type = string
}

variable "user_pool_domain" {
  type = string
}
