module lambda {
  source = "./modules/lambda"

  region                    = var.region
  function_name             = var.lambda_name
  frontend_base_url         = var.frontend_base_url
}

module cognito {
  source = "./modules/cognito"

  region                    = var.region
  pool_name                 = var.pool_name
  custom_message_lambda_arn = module.lambda.arn
  user_pool_domain          = var.user_pool_domain
  frontend_base_url         = var.frontend_base_url
}
