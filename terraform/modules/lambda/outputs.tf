output "aws_lambda_function_invoke_arn" {
  description = "Lambda URI"
  value       = aws_lambda_function.lambda_function.invoke_arn
}

output "aws_lambda_function_arn" {
  description = "Lambda ARN"
  value       = aws_lambda_function.lambda_function.arn
}