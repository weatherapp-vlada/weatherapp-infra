data "aws_elastic_beanstalk_hosted_zone" "current" {}

data "aws_lb" "eb_lb" {
  arn = aws_elastic_beanstalk_environment.beanstalkappenv.load_balancers[0]
}

data "aws_secretsmanager_secret_version" "secrets" {
  secret_id = var.secrets
}

locals {
  secrets = jsondecode(
    data.aws_secretsmanager_secret_version.secrets.secret_string
  )
}

data "aws_elastic_beanstalk_solution_stack" "docker_latest" {
  most_recent = true

  name_regex = "^64bit Amazon Linux 2 v(.*) running Docker$"
}
