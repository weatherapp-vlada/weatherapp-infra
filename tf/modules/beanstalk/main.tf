resource "aws_elastic_beanstalk_application" "elasticapp" {
  name = var.application_name
}

resource "aws_elastic_beanstalk_environment" "beanstalkappenv" {
  name                = "${var.application_name}-env"
  application         = aws_elastic_beanstalk_application.elasticapp.name
  solution_stack_name = data.aws_elastic_beanstalk_solution_stack.docker_latest.name
  tier                = "WebServer"

  setting {
    resource  = ""
    namespace = "aws:elasticbeanstalk:environment"
    name      = "ServiceRole"
    value     = "aws-elasticbeanstalk-service-role"
  }

  setting {
    resource  = ""
    namespace = "aws:ec2:vpc"
    name      = "VPCId"
    value     = var.vpc_id
  }

  setting {
    resource  = ""
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "IamInstanceProfile"
    value     = "aws-elasticbeanstalk-ec2-role"
  }

  setting {
    resource  = ""
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "SecurityGroups"
    value     = aws_security_group.app.id
  }

  setting {
    resource  = ""
    namespace = "aws:ec2:vpc"
    name      = "AssociatePublicIpAddress"
    value     = "true"
  }

  setting {
    resource  = ""
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "DisableIMDSv1"
    value     = "true"
  }

  setting {
    resource  = ""
    namespace = "aws:ec2:vpc"
    name      = "Subnets"
    value     = join(",", sort(var.ec2_subnets))
  }

  setting {
    resource  = ""
    namespace = "aws:ec2:vpc"
    name      = "ELBSubnets"
    value     = join(",", sort(var.elb_subnets))
  }

  setting {
    resource  = ""
    namespace = "aws:elasticbeanstalk:environment:process:default"
    name      = "MatcherHTTPCode"
    value     = "200"
  }

  setting {
    resource  = ""
    namespace = "aws:elasticbeanstalk:environment"
    name      = "LoadBalancerType"
    value     = "application"
  }

  setting {
    resource  = ""
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "InstanceType"
    value     = var.instance_type
  }

  setting {
    resource  = ""
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "RootVolumeType"
    value     = "gp3"
  }

  setting {
    resource  = ""
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "RootVolumeSize"
    value     = var.disk_size
  }

  setting {
    resource  = ""
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "RootVolumeIOPS"
    value     = 3000
  }

  setting {
    resource  = ""
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "RootVolumeThroughput"
    value     = 125
  }

  setting {
    resource  = ""
    namespace = "aws:ec2:vpc"
    name      = "ELBScheme"
    value     = "internet facing"
  }

  setting {
    resource  = ""
    namespace = "aws:autoscaling:asg"
    name      = "MinSize"
    value     = 1
  }

  setting {
    resource  = ""
    namespace = "aws:autoscaling:asg"
    name      = "MaxSize"
    value     = 4
  }

  setting {
    resource  = ""
    namespace = "aws:elasticbeanstalk:healthreporting:system"
    name      = "SystemType"
    value     = "enhanced"
  }

  setting {
    resource  = ""
    namespace = "aws:autoscaling:updatepolicy:rollingupdate"
    name      = "RollingUpdateEnabled"
    value     = true
  }

  setting {
    resource  = ""
    namespace = "aws:autoscaling:updatepolicy:rollingupdate"
    name      = "RollingUpdateType"
    value     = "Health"
  }

  setting {
    resource  = ""
    namespace = "aws:autoscaling:updatepolicy:rollingupdate"
    name      = "MinInstancesInService"
    value     = 1
  }

  setting {
    resource  = ""
    namespace = "aws:elasticbeanstalk:command"
    name      = "DeploymentPolicy"
    value     = "RollingWithAdditionalBatch"
  }

  setting {
    resource  = ""
    namespace = "aws:autoscaling:updatepolicy:rollingupdate"
    name      = "MaxBatchSize"
    value     = 1
  }

  setting {
    resource  = ""
    namespace = "aws:elasticbeanstalk:command"
    name      = "BatchSizeType"
    value     = "Percentage"
  }

  setting {
    resource  = ""
    namespace = "aws:elasticbeanstalk:command"
    name      = "BatchSize"
    value     = 30
  }

  ###=========================== Logging ========================== ###

  setting {
    resource  = ""
    namespace = "aws:elasticbeanstalk:hostmanager"
    name      = "LogPublicationControl"
    value     = false
  }

  setting {
    resource  = ""
    namespace = "aws:elasticbeanstalk:cloudwatch:logs"
    name      = "StreamLogs"
    value     = true
  }

  setting {
    resource  = ""
    namespace = "aws:elasticbeanstalk:cloudwatch:logs"
    name      = "DeleteOnTerminate"
    value     = true
  }

  setting {
    resource  = ""
    namespace = "aws:elasticbeanstalk:cloudwatch:logs"
    name      = "RetentionInDays"
    value     = 7
  }

  ###=========================== Load Balancer ========================== ###
  setting {
    resource  = ""
    namespace = "aws:elbv2:listener:default"
    name      = "ListenerEnabled"
    value     = false
  }

  setting {
    resource  = ""
    namespace = "aws:elbv2:listener:443"
    name      = "ListenerEnabled"
    value     = true
  }

  setting {
    resource  = ""
    namespace = "aws:elbv2:listener:443"
    name      = "Protocol"
    value     = "HTTPS"
  }

  setting {
    resource  = ""
    namespace = "aws:elbv2:listener:443"
    name      = "SSLCertificateArns"
    value     = var.certificate_arn
  }

  setting {
    resource  = ""
    namespace = "aws:elbv2:listener:443"
    name      = "SSLPolicy"
    value     = "ELBSecurityPolicy-2016-08"
  }

  setting {
    resource  = ""
    namespace = "aws:elasticbeanstalk:environment:process:default"
    name      = "HealthCheckPath"
    value     = "/health"
  }

  setting {
    resource  = ""
    namespace = "aws:elasticbeanstalk:environment:process:default"
    name      = "Port"
    value     = 80
  }

  setting {
    resource  = ""
    namespace = "aws:elasticbeanstalk:environment:process:default"
    name      = "Protocol"
    value     = "HTTP"
  }

  ###=========================== Autoscale trigger ========================== ###

  setting {
    resource  = ""
    namespace = "aws:autoscaling:trigger"
    name      = "MeasureName"
    value     = "CPUUtilization"
  }

  setting {
    resource  = ""
    namespace = "aws:autoscaling:trigger"
    name      = "Statistic"
    value     = "Average"
  }

  setting {
    resource  = ""
    namespace = "aws:autoscaling:trigger"
    name      = "Unit"
    value     = "Percent"
  }

  setting {
    resource  = ""
    namespace = "aws:autoscaling:trigger"
    name      = "LowerThreshold"
    value     = 20
  }

  setting {
    resource  = ""
    namespace = "aws:autoscaling:trigger"
    name      = "LowerBreachScaleIncrement"
    value     = -1
  }

  setting {
    resource  = ""
    namespace = "aws:autoscaling:trigger"
    name      = "UpperThreshold"
    value     = 60
  }

  setting {
    resource  = ""
    namespace = "aws:autoscaling:trigger"
    name      = "UpperBreachScaleIncrement"
    value     = 1
  }

  setting {
    resource  = ""
    namespace = "aws:elasticbeanstalk:managedactions"
    name      = "ManagedActionsEnabled"
    value     = "true"
  }

  setting {
    resource  = ""
    namespace = "aws:elasticbeanstalk:managedactions"
    name      = "PreferredStartTime"
    value     = "Tue:10:00"
  }

  setting {
    resource  = ""
    namespace = "aws:elasticbeanstalk:managedactions:platformupdate"
    name      = "UpdateLevel"
    value     = "minor"
  }

  setting {
    resource  = ""
    namespace = "aws:elasticbeanstalk:managedactions:platformupdate"
    name      = "InstanceRefreshEnabled"
    value     = "true"
  }

  ###=========================== Env vars ========================== ###
  setting {
    resource  = ""
    namespace = "aws:elasticbeanstalk:application:environment"
    name      = "DB_HOST"
    value     = var.db_host
  }

  setting {
    resource  = ""
    namespace = "aws:elasticbeanstalk:application:environment"
    name      = "DB_PORT"
    value     = var.db_port
  }

  setting {
    resource  = ""
    namespace = "aws:elasticbeanstalk:application:environment"
    name      = "DB_NAME"
    value     = var.db_name
  }

  setting {
    resource  = ""
    namespace = "aws:elasticbeanstalk:application:environment"
    name      = "DB_USERNAME"
    value     = local.secrets.db_username
  }

  setting {
    resource  = ""
    namespace = "aws:elasticbeanstalk:application:environment"
    name      = "DB_PASSWORD"
    value     = local.secrets.db_password
  }

  setting {
    resource  = ""
    namespace = "aws:elasticbeanstalk:application:environment"
    name      = "OPENWEATHER_APIKEY"
    value     = local.secrets.openweathermap_apikey
  }

  setting {
    resource  = ""
    namespace = "aws:elasticbeanstalk:application:environment"
    name      = "COGNITO_ISSUER_URI"
    value     = var.cognito_issuer_uri
  }

  setting {
    resource  = ""
    namespace = "aws:elasticbeanstalk:application:environment"
    name      = "COGNITO_CLIENT_ID"
    value     = var.cognito_client_id
  }

  setting {
    resource  = ""
    namespace = "aws:elasticbeanstalk:application:environment"
    name      = "COGNITO_JWK_URI"
    value     = var.cognito_jwk_uri
  }

  setting {
    resource  = ""
    namespace = "aws:elasticbeanstalk:application:environment"
    name      = "COGNITO_CONFIRM_USER_BASE_URL"
    value     = var.cognito_confirm_user_base_url
  }
}

resource "aws_lb_listener" "https_redirect" {
  load_balancer_arn = aws_elastic_beanstalk_environment.beanstalkappenv.load_balancers[0]
  port              = 80
  protocol          = "HTTP"

  default_action {
    type = "redirect"

    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}

resource "aws_security_group" "app" {
  vpc_id = var.vpc_id
  name   = "Application security group"

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group_rule" "allow_postgres" {
  type                     = "ingress"
  from_port                = 5432
  to_port                  = 5432
  protocol                 = "tcp"
  security_group_id        = var.rds_sg
  source_security_group_id = aws_security_group.app.id
}


resource "aws_security_group_rule" "allow_http" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = tolist(data.aws_lb.eb_lb.security_groups)[0]
}
