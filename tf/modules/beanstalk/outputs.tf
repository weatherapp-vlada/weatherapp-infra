output "env_name" {
  value = aws_elastic_beanstalk_environment.beanstalkappenv.name
}

output "app_name" {
  value = aws_elastic_beanstalk_application.elasticapp.name
}

output "asg_name" {
  value = aws_elastic_beanstalk_environment.beanstalkappenv.autoscaling_groups[0]
}

output "lb_arn" {
  value = aws_elastic_beanstalk_environment.beanstalkappenv.load_balancers[0]
}

output "url" {
  value = "https://${aws_route53_record.myapp.fqdn}"
}

output "cognito_issuer_uri" {
  value = local.cognito_issuer_uri
}
