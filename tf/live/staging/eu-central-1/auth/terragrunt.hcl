terraform {
  source = "../../../../modules//auth"
}

include {
  path = find_in_parent_folders()
}

# dependency "tls" {
#   config_path = "../tls"
# }

inputs = {
  pool_name = "weatherapp-pool"
  lambda_name = "cognito-confirmation"
}
