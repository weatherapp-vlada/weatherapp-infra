terraform {
  source = "../../../../modules//auth"
}

include {
  path = find_in_parent_folders()
}

dependency "dns" {
  config_path = "../dns"
}

inputs = {
  pool_name = "inviggde-pool"
  user_pool_domain = "auth.${dependency.dns.outputs.domain_name}"
  lambda_name = "cognito-confirmation"
}
