output "cognito_user_pool_id" {
  value = aws_cognito_user_pool.pool.id
}

output "cognito_issuer_uri" {
  value = "https://cognito-idp.${var.region}.amazonaws.com/${aws_cognito_user_pool.pool.id}"
}

output "cognito_client_id" {
  value = aws_cognito_user_pool_client.confidential.id
}

output "cognito_client_secret" {
  value = aws_cognito_user_pool_client.confidential.client_secret
}

# https://aws.amazon.com/premiumsupport/knowledge-center/decode-verify-cognito-json-token/
output "cognito_jwk_uri" {
  value = "https://cognito-idp.${var.region}.amazonaws.com/${aws_cognito_user_pool.pool.id}/.well-known/jwks.json"
}

# https://stackoverflow.com/questions/47159568/how-to-redirect-after-confirm-amazon-cognito-using-confirmation-url
output "cognito_confirm_user_base_url" {
  value = "https://${aws_cognito_user_pool.pool.domain}.auth.${var.region}.amazoncognito.com/confirmUser"
}
