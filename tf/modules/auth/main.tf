module lambda {
  source = "./modules/lambda"

  region                    = var.region
  function_name             = var.lambda_name
  frontend_base_url         = var.frontend_base_url
}

module auth_domain {
  source = "../dns"
  providers = {
    aws = aws.us_east_1 # auth cert must be in us-east-1
  }

  zone_name = var.zone_name
  domain_name = var.user_pool_domain
}

module cognito {
  source = "./modules/cognito"

  region                    = var.region
  pool_name                 = var.pool_name
  custom_message_lambda_arn = module.lambda.arn
  user_pool_domain          = var.user_pool_domain
  frontend_base_url         = var.frontend_base_url
  auth_certificate_arn      = module.auth_domain.certificate_arn
  depends_on = [module.auth_domain] # wait for cert validation
}
