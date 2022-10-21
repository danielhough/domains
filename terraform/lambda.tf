resource "aws_lambda_function" "lambda_func" {
  filename          = data.archive_file.lambda_zip.output_path
  function_name    = local.app_id
  handler          = "app"
  source_code_hash = data.archive_file.lambda_zip.output_base64sha256
  runtime          = "go1.x"
  role             = aws_iam_role.domains_lambda_role.arn
}

resource "aws_iam_role" "domains_lambda_role" {
  name = "role-${local.app_id}"
  path = "/service-role/"
#  permissions_boundary = local.config.permission_boundary_arn
  assume_role_policy = data.aws_iam_policy_document.assume_role_policy_document.json

  inline_policy {
    name   = "test_policy"
    policy = data.aws_iam_policy_document.test_policy_document.json
  }
}

data "aws_iam_policy_document" "assume_role_policy_document" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "test_policy_document" {
  statement {
    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents",
      "logs:AssociateKmsKey"
    ]
    resources = ["*"]

  }
}
