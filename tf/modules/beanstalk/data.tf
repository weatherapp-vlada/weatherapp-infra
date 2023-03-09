data "aws_elastic_beanstalk_hosted_zone" "current" {}

data "aws_lb" "eb_lb" {
  arn = aws_elastic_beanstalk_environment.beanstalkappenv.load_balancers[0]
}

data "aws_secretsmanager_secret_version" "secrets" {
  secret_id = var.secrets
}

locals {
  cognito_issuer_uri = "https://${var.user_pool_domain}" # "https://cognito-idp.${var.region}.amazonaws.com/${aws_cognito_user_pool.pool.id}"
  secrets = jsondecode(
    data.aws_secretsmanager_secret_version.secrets.secret_string
  )
  # https://aws.amazon.com/premiumsupport/knowledge-center/decode-verify-cognito-json-token/
  cognito_jwk_uri = "${local.cognito_issuer_uri}/.well-known/jwks.json"

  # https://stackoverflow.com/questions/47159568/how-to-redirect-after-confirm-amazon-cognito-using-confirmation-url
  cognito_confirm_user_base_url = "${local.cognito_issuer_uri}/confirmUser"
}

data "aws_elastic_beanstalk_solution_stack" "docker_latest" {
  most_recent = true

  name_regex = "^64bit Amazon Linux 2 v(.*) running Docker$"
}

