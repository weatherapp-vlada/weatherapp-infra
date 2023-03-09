terraform {
  source = "../../../../modules//dns"
}

include {
  path = find_in_parent_folders()
}

dependency "auth" {
  config_path = "../auth"
}

dependency "tls" {
  config_path = "../tls"
}

inputs = {
  cognito_user_pool_id = dependency.auth.outputs.cognito_user_pool_id
  user_pool_domain = "auth.${dependency.tls.outputs.domain_name}" # TODO: DRY this
}
