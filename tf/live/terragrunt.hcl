remote_state {
  backend = "local"
  config = {
    path = "${get_parent_terragrunt_dir()}/${path_relative_to_include()}/terraform.tfstate"
  }

  generate = {
    path      = "backend.tf"
    if_exists = "overwrite"
  }
}

locals {
  dns_vars = read_terragrunt_config(find_in_parent_folders("dns.hcl"))
  region_vars = read_terragrunt_config(find_in_parent_folders("region.hcl"))
}

inputs = merge(
  local.dns_vars.locals,
  local.region_vars.locals,
)

generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite"
  contents = <<EOF
provider "aws" {
  region = "${local.region_vars.locals.region}"
  default_tags {
    tags = {
      ManagedBy  = "Terraform"
      Application = "WeatherApp"
    }
  }
}
EOF
}
