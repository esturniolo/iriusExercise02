resource "aws_cloudwatch_event_rule" "event_rule" {
  name        = "event_rule"
  description = "CloudWatch event rule"

  event_pattern = <<PATTERN
{
  "source": [
    "aws.apigateway"
  ],
  "detail-type": [
    "API Gateway Request"
  ],
  "detail": {
    "httpMethod": [
      "POST"
    ],
    "requestPath": [
      "example"
    ],
    "stage": [
      "prod"
    ]
  }
}
PATTERN
}

resource "aws_cloudwatch_event_target" "event_target" {
  rule        = aws_cloudwatch_event_rule.event_rule.name
  target_id   = "target_id"
  arn         = var.aws_lambda_function_arn
}