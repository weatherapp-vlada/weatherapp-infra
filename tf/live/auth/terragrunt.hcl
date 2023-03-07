terraform {
  source = "../../modules//auth"
}

include {
  path = find_in_parent_folders()
}

dependency "amplify" {
  config_path = "../amplify"
}

inputs = {
  pool_name = "inviggde-pool"
  user_pool_domain = "inviggde-auth"
  lambda_name = "cognito-confirmation"
  frontend_base_url = dependency.amplify.outputs.url
}
