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

generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite"
  contents = <<EOF
provider "aws" {
  region = "eu-central-1" # TODO: get this from common.hcl somehow
  default_tags {
    tags = {
      ManagedBy  = "Terraform"
      Application = "WeatherApp"
    }
  }
}
EOF
}
