terraform {
  source = "../../../../modules//amplify"
}

include {
  path = find_in_parent_folders()
}

dependency "beanstalk" {
  config_path = "../beanstalk"
}

dependency "auth" {
  config_path = "../auth"
}

dependency "tls" {
  config_path = "../tls"
}

inputs = {
  name = "WeatherApp"
  repository_url = "https://github.com/weatherapp-vlada/weatherapp-front"
  branch_name = "main"
  cognito_issuer_uri = "auth.${dependency.tls.outputs.domain_name}" # "https://cognito-idp.${var.region}.amazonaws.com/${aws_cognito_user_pool.pool.id}"
  cognito_client_id = dependency.auth.outputs.cognito_client_id
  cognito_client_secret = dependency.auth.outputs.cognito_client_secret
  cognito_user_pool_id = dependency.auth.outputs.cognito_user_pool_id
  secrets = "weatherapp-secrets"
  user_pool_domain = "auth.${dependency.tls.outputs.domain_name}"
  # github_access_token = "" # set in env var
}
