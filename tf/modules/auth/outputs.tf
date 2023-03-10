locals {
  cognito_user_pool_id = module.cognito.cognito_user_pool_id
  cognito_issuer_uri   = "https://cognito-idp.${var.region}.amazonaws.com/${local.cognito_user_pool_id}"
}

output "cognito_user_pool_id" {
  value = local.cognito_user_pool_id
}

output "cognito_client_id" {
  value = module.cognito.cognito_client_id
}

output "cognito_client_secret" {
  value     = module.cognito.cognito_client_secret
  sensitive = true
}

output "cognito_issuer_uri" {
  value = local.cognito_issuer_uri # "https://cognito-idp.${var.region}.amazonaws.com/${aws_cognito_user_pool.pool.id}"
}

output "cognito_jwk_uri" {
  value = "${local.cognito_issuer_uri}/.well-known/jwks.json" # https://aws.amazon.com/premiumsupport/knowledge-center/decode-verify-cognito-json-token/
}

output "cognito_confirm_user_base_url" {
  value = "auth.${var.domain_name}/confirmUser" # https://stackoverflow.com/questions/47159568/how-to-redirect-after-confirm-amazon-cognito-using-confirmation-url
}
