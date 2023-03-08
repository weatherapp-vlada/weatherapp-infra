data "aws_iam_policy_document" "amplify_assume_role_policy_doc" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["amplify.amazonaws.com"]
    }
  }
}

data "aws_secretsmanager_secret_version" "secrets" {
  secret_id = var.secrets
}

locals {
  secrets = jsondecode(
    data.aws_secretsmanager_secret_version.secrets.secret_string
  )
}