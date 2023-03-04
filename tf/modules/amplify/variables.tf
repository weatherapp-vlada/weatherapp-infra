variable "region" {
  type = string
  default = "eu-central-1"
}

variable "name" {
  type = string
}

variable "repository_url" {
  type = string
}

variable "github_access_token" {
  type = string
  sensitive = true
}

variable "backend_url" {
  type = string
}

variable "domain_name" {
  type = string
}

variable "branch_name" {
  type = string
}