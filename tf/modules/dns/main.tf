module "auth_cert" {
  source = "../tls"
  providers = {
    aws = aws.us_east_1 # auth cert must be in us-east-1
  }

  zone_name   = var.zone_name
  domain_name = var.user_pool_domain
}

resource "aws_cognito_user_pool_domain" "main" {
  domain          = var.user_pool_domain
  certificate_arn = module.auth_cert.certificate_arn
  user_pool_id    = var.cognito_user_pool_id
  depends_on      = [aws_amplify_domain_association.main] # A record must exists
}

resource "aws_amplify_domain_association" "main" {
  app_id                = aws_amplify_app.app.id
  domain_name           = var.domain_name
  wait_for_verification = true

  sub_domain {
    branch_name = aws_amplify_branch.main.branch_name
    prefix      = ""
  }

  sub_domain {
    branch_name = aws_amplify_branch.main.branch_name
    prefix      = "www"
  }
}
