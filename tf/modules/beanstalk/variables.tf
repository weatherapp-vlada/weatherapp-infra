variable "application_name" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "ec2_subnets" {
  type = list(string)
}

variable "elb_subnets" {
  type = list(string)
}

variable "instance_type" {
  type = string
}

variable "disk_size" {
  type = string
}

variable "certificate_arn" {
  type = string
}

variable "zone_name" {
  type = string
}

variable "backend_domain" {
  type = string
}

variable "secrets" {
  type = string
}

variable "db_host" {
  type = string
}

variable "db_port" {
  type = string
}

variable "db_name" {
  type = string
}

variable "rds_sg" {
  type = string
}

variable "cognito_client_id" {
  type = string
}

variable "cognito_issuer_uri" {
  type = string
}

variable "cognito_jwk_uri" {
  type = string
}

variable "cognito_confirm_user_base_url" {
  type = string
}

