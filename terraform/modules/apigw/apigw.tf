resource "aws_api_gateway_rest_api" "apigw_rest_api" {
  name        = "rest_api"
  description = "Rest API"
}

resource "aws_api_gateway_resource" "apigw_resource" {
  rest_api_id = aws_api_gateway_rest_api.apigw_rest_api.id
  parent_id   = aws_api_gateway_rest_api.apigw_rest_api.root_resource_id
  path_part   = "path_part"
}

resource "aws_api_gateway_method" "apigw_method" {
  rest_api_id   = aws_api_gateway_rest_api.apigw_rest_api.id
  resource_id   = aws_api_gateway_resource.apigw_resource.id
  http_method   = "POST"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "apigw_integration" {
  rest_api_id             = aws_api_gateway_rest_api.apigw_rest_api.id
  resource_id             = aws_api_gateway_resource.apigw_resource.id
  http_method             = aws_api_gateway_method.apigw_method.http_method
  integration_http_method = "POST"
  type                    = "AWS"
  uri                     = var.aws_lambda_function.lambda_function.invoke_arn
}
