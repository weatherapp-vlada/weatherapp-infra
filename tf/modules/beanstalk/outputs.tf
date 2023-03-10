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

output "beanstalk_cname" {
  value = aws_elastic_beanstalk_environment.beanstalkappenv.cname
}

output "beanstalk_zone_id" {
  value = data.aws_elastic_beanstalk_hosted_zone.current.id
}
