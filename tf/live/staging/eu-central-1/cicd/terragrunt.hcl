terraform {
  source = "../../../../modules//cicd"
}

include {
  path = find_in_parent_folders()
}

dependency "beanstalk" {
  config_path = "../beanstalk"
}

inputs = {
  codepipeline_name = "weatherapp-pipeline"
  codebuild_project_name = "weatherapp-codebuild"
  github_repo = "weatherapp-vlada/weatherapp-back",
  github_connection_arn = "arn:aws:codestar-connections:us-east-2:692885578773:connection/0ee2a05b-c3d3-4a4f-812b-5a67accfeed0"
  beanstalk_app_name = dependency.beanstalk.outputs.app_name
  beanstalk_env_name = dependency.beanstalk.outputs.env_name
}