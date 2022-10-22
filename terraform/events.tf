resource "aws_cloudwatch_event_rule" "schedule" {
  name = "schedule-${local.app_id}"
  description = "Schedule for Lambda function"
  schedule_expression = var.schedule
}

resource "aws_cloudwatch_event_target" "schedule_lambda" {
  rule = aws_cloudwatch_event_rule.schedule.name
  target_id = "lambda_func"
  arn = aws_lambda_function.lambda_func.arn
}

resource "aws_lambda_permission" "allow_events_bridge_to_run_lambda" {
  statement_id = "AllowExecutionFromCloudWatch"
  action = "lambda:InvokeFunction"
  function_name = aws_lambda_function.lambda_func.function_name
  principal = "events.amazonaws.com"
}
