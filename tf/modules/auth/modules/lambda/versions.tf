provider "aws" {
  region = var.region

  default_tags {
    tags = {
      ManagedBy  = "Terraform"
      Application = "WeatherApp"
    }
  }
}

terraform {
  required_providers {
    archive = {
      source = "hashicorp/archive"
      version = "~> 2.0"
    }
  }
}