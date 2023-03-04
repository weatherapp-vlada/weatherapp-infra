terraform {
  source = "../../modules//amplify"
}

include {
  path = find_in_parent_folders()
}

dependency "beanstalk" {
  config_path = "../beanstalk"
}

inputs = {
  name = "WeatherApp"
  repository_url = "https://github.com/weatherapp-vlada/weatherapp-front"
  branch_name = "main"
  backend_url = dependency.beanstalk.outputs.url
  domain_name = "inviggde.com"
  # github_access_token = "" # set in env var
}
