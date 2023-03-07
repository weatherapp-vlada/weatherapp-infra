
data "aws_caller_identity" "default" {}

data "aws_iam_policy_document" "lambda_assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

data "aws_iam_policy_document" "lambda_policy_doc" {
  statement {
    actions = [
      "logs:CreateLogGroup"
    ]
    resources = ["arn:aws:logs:${var.region}:${data.aws_caller_identity.default.account_id}:*"]
  }

  statement {
    actions = [
      "logs:CreateLogStream",
      "logs:PutLogEvents"
    ]
    resources = ["arn:aws:logs:${var.region}:${data.aws_caller_identity.default.account_id}:log-group:/aws/lambda/${var.function_name}:*"]
  }
}

locals {
  lambda_project = "${path.module}/cognito_custom_message"
}

data "external" "lambda_build" {
  program = ["bash", "-c", <<EOT
(npm ci && npm run build) >&2 && echo "{\"dest\": \"dist\"}"
EOT
]
	working_dir = "${local.lambda_project}"
}

data "archive_file" "lambda_zip" {
	type        = "zip"
	output_path = "/tmp/lambda_zips/cognito_custom_message.zip"
	source_dir  = "${local.lambda_project}/${data.external.lambda_build.result.dest}"
}