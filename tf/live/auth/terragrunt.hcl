terraform {
  source = "../../modules//auth"
}

include {
  path = find_in_parent_folders()
}

inputs = {
  pool_name = "inviggde-pool"
  user_pool_domain = "inviggde-auth"
  lambda_name = "cognito-confirmation"
  frontend_base_url = "https://inviggde.com" # TODO: must be same as url output of amplify module but if we add dependency in causes circular dependency
}
