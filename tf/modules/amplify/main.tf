resource "aws_iam_role" "amplify_role" {
  name               = "amplify_deploy_terraform_role"
  assume_role_policy = data.aws_iam_policy_document.amplify_assume_role_policy_doc.json
}

resource "aws_iam_role_policy" "amplify_role_policy" {
  name   = "amplify_iam_role_policy"
  role   = aws_iam_role.amplify_role.id
  policy = file("${path.module}/amplify_role_policies.json")
}

resource "aws_amplify_app" "app" {
  name         = var.name
  repository   = var.repository_url
  access_token = var.github_access_token

  # The default build_spec added by the Amplify Console for React.
  build_spec = file("${path.module}/buildspec.yml")

  iam_service_role_arn = aws_iam_role.amplify_role.arn
  platform             = "WEB_COMPUTE" # required for Next.js v13

  custom_rule {
    source = "/<*>"
    status = "200"
    target = "https://<*>.cloudfront.net/<*>"
  }

  # # The default rewrites and redirects added by the Amplify Console.
  custom_rule {
    source = "/<*>"
    status = "404"
    target = "/index.html"
  }

  environment_variables = {
    NEXT_PUBLIC_BACKEND_URL = "https://${var.backend_url}"
    COGNITO_CLIENT_ID       = var.cognito_client_id
    COGNITO_CLIENT_SECRET   = var.cognito_client_secret
    COGNITO_ISSUER          = var.cognito_issuer_uri
    NEXTAUTH_SECRET         = local.secrets.nextauth_secret
    NEXTAUTH_URL            = "https://${var.domain_name}"
  }
}

resource "aws_amplify_branch" "main" {
  app_id      = aws_amplify_app.app.id
  branch_name = var.branch_name

  enable_auto_build = true
  framework         = "Next.js - SSR"
}

resource "aws_amplify_domain_association" "main" {
  app_id                = aws_amplify_app.app.id
  domain_name           = var.domain_name
  wait_for_verification = true

  sub_domain {
    branch_name = aws_amplify_branch.main.branch_name
    prefix      = ""
  }

  sub_domain {
    branch_name = aws_amplify_branch.main.branch_name
    prefix      = "www"
  }
}

module "auth_domain" {
  source = "../dns"
  providers = {
    aws = aws.us_east_1 # auth cert must be in us-east-1
  }

  zone_name   = var.zone_name
  domain_name = var.user_pool_domain
}

resource "aws_cognito_user_pool_domain" "main" {
  domain          = var.user_pool_domain
  certificate_arn = module.auth_domain.certificate_arn
  user_pool_id    = var.cognito_user_pool_id
  depends_on      = [aws_amplify_domain_association.main] # A record must exists
}
