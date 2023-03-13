module "lambda" {
  source = "./modules/lambda"

  region            = var.region
  function_name     = var.lambda_name
  frontend_base_url = var.frontend_base_url
}

module "cognito" {
  source = "./modules/cognito"

  region                   = var.region
  pool_name                = var.pool_name
  post_confirmation_lambda = module.lambda.lambda
  frontend_base_url        = var.frontend_base_url
}
