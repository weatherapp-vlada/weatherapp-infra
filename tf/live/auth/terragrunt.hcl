terraform {
  source = "../../modules//auth"
}

include {
  path = find_in_parent_folders()
}

locals {
  common_vars = read_terragrunt_config(find_in_parent_folders("common.hcl"))
}

inputs = {
  pool_name = "inviggde-pool"
  user_pool_domain = "auth.${local.common_vars.inputs.domain_name}"
  lambda_name = "cognito-confirmation"
  frontend_base_url = "https://${local.common_vars.inputs.domain_name}"
  zone_name = local.common_vars.inputs.zone_name
  region = local.common_vars.inputs.region
}
