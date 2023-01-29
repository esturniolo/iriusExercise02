terraform {

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.30"
    }
  }

  backend "s3" {
    region         = "eu-west-3"
    bucket         = "iriustest-state-bucket"
    key            = "terraform.tfstate"
    dynamodb_table = "iriustest-state-lock"
    encrypt        = true
  }
}

provider "aws" {
  region = var.aws_region
  default_tags {
    tags = {
      name = "iriustest"
    }
  }
}

module "lambda" {
  source = "./modules/lambda"

  aws_iam_role_lambda_role = module.aws_iam_role_lambda_role_arn
}

module "apigw" {
  source = "./modules/apigw"

  aws_lambda_function_uri = module.aws_lambda_function_invoke_arn
}

module "iam" {
  source = "./modules/iam"

  aws_s3_bucket_json_bucket = module.aws_s3_bucket_json_bucket_arn
}

module "cloudwatch" {
  source = "./modules/cloudwatch"

  aws_lambda_function_arn = module.aws_lambda_function_arn
}