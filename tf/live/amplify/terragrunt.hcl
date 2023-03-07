terraform {
  source = "../../modules//amplify"
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
  domain_name = "inviggde.com"
  cognito_client_id = dependency.auth.outputs.cognito_client_id
  cognito_issuer_uri = dependency.auth.outputs.cognito_issuer_uri
  cognito_client_secret = dependency.auth.outputs.cognito_client_secret
  # github_access_token = "" # set in env var
}
