resource "aws_cognito_user_pool" "pool" {
  name = var.pool_name
  
  auto_verified_attributes = [
    "email"
  ]

  username_attributes = [
    "email"
  ]

  account_recovery_setting {
    recovery_mechanism {
      name     = "verified_email"
      priority = 1
    }
  }

  username_configuration {
    case_sensitive = false
  }

  lambda_config {
    custom_message = var.custom_message_lambda_arn
  }

  schema {
    name                     = "admin"
    attribute_data_type      = "String"
    developer_only_attribute = false
    mutable                  = true
    required                 = false

    string_attribute_constraints {
      max_length = "256"
      min_length = "1"
    }
  }
  
  schema {
    name                     = "email"
    attribute_data_type      = "String"
    developer_only_attribute = false
    mutable                  = true
    required                 = true

    string_attribute_constraints {
      max_length = "100"
      min_length = "0"
    }
  }

  schema {
    name                     = "name"
    attribute_data_type      = "String"
    developer_only_attribute = false
    mutable                  = true
    required                 = true

    string_attribute_constraints {
      max_length = "100"
      min_length = "0"
    }
  }

  schema {
    name                     = "family_name"
    attribute_data_type      = "String"
    developer_only_attribute = false
    mutable                  = true
    required                 = true

    string_attribute_constraints {
      max_length = "100"
      min_length = "0"
    }
  }
}

resource "aws_cognito_user_pool_domain" "main" {
  domain       = var.user_pool_domain
  user_pool_id = aws_cognito_user_pool.pool.id
}