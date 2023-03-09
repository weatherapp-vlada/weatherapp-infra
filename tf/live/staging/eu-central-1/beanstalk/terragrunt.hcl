terraform {
  source = "../../../../modules//beanstalk"
}

include {
  path = find_in_parent_folders()
}

dependency "vpc" {
  config_path = "../vpc"
}

dependency "dns" {
  config_path = "../dns"
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
  certificate_arn = dependency.dns.outputs.certificate_arn
  route53_zone_id = dependency.dns.outputs.zone_id
  secrets = "weatherapp-secrets"
  db_host = dependency.rds.outputs.address
  db_port = dependency.rds.outputs.port
  db_name = dependency.rds.outputs.db_name
  rds_sg = dependency.rds.outputs.sg
  cognito_client_id = dependency.auth.outputs.cognito_client_id
  cognito_user_pool_id = dependency.auth.outputs.cognito_user_pool_id
  user_pool_domain = "auth.${dependency.dns.outputs.domain_name}"

}
