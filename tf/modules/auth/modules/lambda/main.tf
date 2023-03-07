resource "aws_iam_policy" "lambda_policy" {
  name   = "${var.function_name}-policy"
  policy = data.aws_iam_policy_document.lambda_policy_doc.json
  path = "/service-role/"
}

resource "aws_iam_role" "lambda_role" {
  name               = "${var.function_name}-role"
  assume_role_policy = data.aws_iam_policy_document.lambda_assume_role.json
  path               = "/service-role/"
  managed_policy_arns = [
    aws_iam_policy.lambda_policy.arn
  ]
}

resource "aws_lambda_function" "cognito_custom_message" {
  function_name    = var.function_name
  filename         = "${path.module}/dummy.zip"
  role             = aws_iam_role.lambda_role.arn
  handler          = "index.handler"
  runtime          = "nodejs16.x"

    lifecycle {
      # these will be changed by GitHub Action in Lambda's CI/CD pipeline
      ignore_changes = [
        filename,
        source_code_hash
      ]
    }


  environment {
    variables = {
      "BASE_URL" = var.frontend_base_url
    }
  }

  ephemeral_storage {
    size = 512
  }

  tracing_config {
    mode = "PassThrough"
  }
}
