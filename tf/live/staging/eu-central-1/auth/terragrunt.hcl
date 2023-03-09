terraform {
  source = "../../../../modules//auth"
}

include {
  path = find_in_parent_folders()
}

# dependency "dns" {
#   config_path = "../dns"
# }

inputs = {
  pool_name = "weatherapp-pool"
  lambda_name = "cognito-confirmation"
}
