resource "aws_secretsmanager_secret_rotation" "this" {
  rotation_lambda_arn = aws_lambda_function.rotation.arn
  secret_id           = var.secret_arn

  rotation_rules {
    automatically_after_days = var.rotation_days
  }
}

resource "aws_lambda_function" "rotation" {
  description      = "Rotate function for ${local.secret_id}"
  filename         = data.archive_file.function.output_path
  function_name    = local.secret_id
  handler          = var.handler
  role             = var.role_arn
  runtime          = var.runtime
  source_code_hash = data.archive_file.function.output_base64sha256
  timeout          = 60

  environment {
    variables = merge(
      var.variables,
      { SECRETS_MANAGER_ENDPOINT = local.endpoint }
    )
  }

  vpc_config {
    security_group_ids = var.security_group_ids
    subnet_ids         = var.subnet_ids
  }

  depends_on = [
    # Wait until the function has permission to attach to the VPC
    aws_iam_role_policy_attachment.function_vpc
  ]
}

data "archive_file" "function" {
  output_path = "${path.module}/${local.secret_id}.zip"
  source_file = var.source_file
  type        = "zip"
}

resource "aws_lambda_permission" "secretsmanager" {
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.rotation.function_name
  principal     = "secretsmanager.amazonaws.com"
  statement_id  = "AllowSecretManager"
}

resource "aws_iam_role_policy_attachment" "function_vpc" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaVPCAccessExecutionRole"
  role       = local.role_name
}

data "aws_region" "this" {}

locals {
  endpoint     = "https://secretsmanager.${local.region}.amazonaws.com"
  region       = data.aws_region.this.name
  role_name    = split("/", var.role_arn)[1]
  secret_parts = split(":", var.secret_arn)
  secret_id    = local.secret_parts[length(local.secret_parts) - 1]
}
