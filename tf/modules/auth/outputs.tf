output "cognito_user_pool_id" {
  value = module.cognito.cognito_user_pool_id
}

output "cognito_client_id" {
  value = module.cognito.cognito_client_id
}

output "cognito_client_secret" {
  value     = module.cognito.cognito_client_secret
  sensitive = true
}
