resource "aws_lambda_function" "lambda_function" {
  filename         = "lambda.zip"
  function_name    = "lambda_function_name"
  role             = var.aws_iam_role_lambda_role
  handler          = "lambda_function.handler"
  source_code_hash = filebase64sha256("lambda.zip")
  runtime          = "python"
  timeout          = "15"
  environment {
    variables = {
      WORDS = "10"
    }
  }
}