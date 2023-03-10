terraform {
  source = "../../../../modules//dns"
}

include {
  path = find_in_parent_folders()
}

dependency "auth" {
  config_path = "../auth"
}

dependency "amplify" {
  config_path = "../amplify"
}

dependency "beanstalk" {
  config_path = "../beanstalk"
}

inputs = {
  cognito_user_pool_id = dependency.auth.outputs.cognito_user_pool_id
  amplify_branch_main_branch_name = dependency.amplify.outputs.amplify_branch_main_branch_name
  amplify_app_id = dependency.amplify.outputs.amplify_app_id
  beanstalk_cname = dependency.beanstalk.outputs.beanstalk_cname
  beanstalk_zone_id = dependency.beanstalk.outputs.beanstalk_zone_id
}
