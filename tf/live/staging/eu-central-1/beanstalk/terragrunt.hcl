terraform {
  source = "../../../../modules//beanstalk"
}

include {
  path = find_in_parent_folders()
}

dependency "vpc" {
  config_path = "../vpc"
}

dependency "tls" {
  config_path = "../tls"
}

dependency "rds" {
  config_path = "../rds"
}

dependency "auth" {
  config_path = "../auth"
}

inputs = {
  application_name = "weatherapp"
  vpc_id = dependency.vpc.outputs.vpc_id
  ec2_subnets = dependency.vpc.outputs.private_subnet_ids
  elb_subnets = dependency.vpc.outputs.public_subnet_ids
  instance_type = "t3.micro"
  disk_size = "20"
  certificate_arn = dependency.tls.outputs.certificate_arn
  secrets = "weatherapp-secrets"
  db_host = dependency.rds.outputs.address
  db_port = dependency.rds.outputs.port
  db_name = dependency.rds.outputs.db_name
  rds_sg = dependency.rds.outputs.sg
  cognito_client_id = dependency.auth.outputs.cognito_client_id
  cognito_issuer_uri = dependency.auth.outputs.cognito_issuer_uri
  cognito_jwk_uri = dependency.auth.outputs.cognito_jwk_uri
  cognito_confirm_user_base_url = dependency.auth.outputs.cognito_confirm_user_base_url
}
