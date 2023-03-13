variable "region" {
  type = string
}

variable "pool_name" {
  type = string
}

variable "post_confirmation_lambda" {
  type = object({
    function_name = string
    arn           = string
  })
}

variable "frontend_base_url" {
  type = string
}
