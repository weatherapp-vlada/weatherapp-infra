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

inputs = {
  name = "WeatherApp"
  repository_url = "https://github.com/weatherapp-vlada/weatherapp-front"
  branch_name = "main"
  backend_url = dependency.beanstalk.outputs.url
  cognito_issuer_uri = dependency.beanstalk.outputs.cognito_issuer_uri
  cognito_client_id = dependency.auth.outputs.cognito_client_id
  cognito_client_secret = dependency.auth.outputs.cognito_client_secret
  secrets = "weatherapp-secrets"
  # github_access_token = "" # set in env var
}
