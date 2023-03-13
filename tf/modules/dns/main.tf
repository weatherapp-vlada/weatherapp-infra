data "aws_route53_zone" "public" {
  name         = var.zone_name
  private_zone = false
}

module "auth_cert" {
  source = "../tls"
  providers = {
    aws = aws.us_east_1 # auth cert must be in us-east-1
  }

  zone_name   = var.zone_name
  domain_name = var.domain_name
}

resource "aws_amplify_domain_association" "main" {
  app_id                = var.amplify_app_id
  domain_name           = var.domain_name
  wait_for_verification = true

  sub_domain {
    branch_name = var.amplify_branch_main_branch_name
    prefix      = ""
  }

  sub_domain {
    branch_name = var.amplify_branch_main_branch_name
    prefix      = "www"
  }
}

resource "aws_route53_record" "myapp" {
  zone_id = data.aws_route53_zone.public.zone_id
  name    = var.backend_domain
  type    = "A"

  alias {
    name                   = var.beanstalk_cname
    zone_id                = var.beanstalk_zone_id
    evaluate_target_health = false
  }
}

resource "aws_cognito_user_pool_domain" "main" {
  domain          = var.user_pool_domain
  certificate_arn = module.auth_cert.certificate_arn
  user_pool_id    = var.cognito_user_pool_id
  depends_on      = [aws_amplify_domain_association.main] # A record must exist
}


resource "aws_route53_record" "auth" {
  zone_id = data.aws_route53_zone.public.zone_id
  name    = var.user_pool_domain
  type    = "A"

  alias {
    name                   = aws_cognito_user_pool_domain.main.cloudfront_distribution_arn
    zone_id                = "Z2FDTNDATAQYW2" # This zone_id is fixed
    evaluate_target_health = false
  }
}
