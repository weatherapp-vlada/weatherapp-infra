output "cognito_user_pool_id" {
  value = module.cognito.cognito_user_pool_id
}

output "cognito_issuer_uri" {
 value = module.cognito.cognito_issuer_uri
}

output "cognito_client_id" {
 value = module.cognito.cognito_client_id
}

output "cognito_client_secret" {
   value = module.cognito.cognito_client_secret
   sensitive = true
}

output "cognito_jwk_uri" {
  value = module.cognito.cognito_jwk_uri
}

output "cognito_confirm_user_base_url" {
 value = module.cognito.cognito_confirm_user_base_url
}

output "user_pool_domain" {
  value = var.user_pool_domain
}

output "auth_certificate_arn" {
  value = module.cognito.auth_certificate_arn
}
