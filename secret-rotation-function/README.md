# Rotating Secret

Creates a rotation function for a Secrets Manager secret. You can combine this
with the [secret module] to create a secret with automatic rotation. You can
read more about secret rotation in the [Secrets Manager developer guide].

Example:

``` terraform
module "auth_token_rotation" {
  source = "github.com/thoughtbot/terraform-aws-secrets//secret-rotation-function"

  # Provide these outputs from the secret module
  role_arn           = module.auth_token.rotation_role_arn
  secret_arn         = module.auth_token.arn

  # Tune these to match your handler function
  handler            = "lambda_function.lambda_handler"
  runtime            = "python3.8"
  source_file        = "${path.module}/myfunction.py"

  # Configure security groups and subnets for your VPC
  security_group_ids = [aws_security_group.function.id]
  subnet_ids         = aws_subnet.private.*.id

  # You can provide Lambda layers as a map of archives
  dependencies = {
    postgres = "${path.module}/postgres.zip"
  }

  # Environment variables to add to the created function
  variables = {
    ACCOUNT_URL = "https://example.com"
  }
}
```

[secret module]: ../secret
[Secrets Manager developer guide]: https://docs.aws.amazon.com/secretsmanager/latest/userguide/rotating-secrets.html

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.14.0 |
| <a name="requirement_archive"></a> [archive](#requirement\_archive) | ~> 2.2 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 4.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_archive"></a> [archive](#provider\_archive) | ~> 2.2 |
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 4.0 |

## Resources

| Name | Type |
|------|------|
| [aws_iam_role_policy_attachment.function_vpc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_lambda_function.rotation](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_function) | resource |
| [aws_lambda_layer_version.dependencies](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_layer_version) | resource |
| [aws_lambda_permission.secretsmanager](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_permission) | resource |
| [aws_secretsmanager_secret_rotation.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secret_rotation) | resource |
| [archive_file.function](https://registry.terraform.io/providers/hashicorp/archive/latest/docs/data-sources/file) | data source |
| [aws_region.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_dependencies"></a> [dependencies](#input\_dependencies) | Map of zip archives containing dependencies | `map(string)` | `{}` | no |
| <a name="input_handler"></a> [handler](#input\_handler) | Handler to invoke in the function package | `string` | n/a | yes |
| <a name="input_role_arn"></a> [role\_arn](#input\_role\_arn) | ARN of the IAM role capable of rotating the secret | `string` | n/a | yes |
| <a name="input_rotation_days"></a> [rotation\_days](#input\_rotation\_days) | Number of days after which the secret is rotated | `number` | `30` | no |
| <a name="input_runtime"></a> [runtime](#input\_runtime) | Runtime of the rotation function | `string` | n/a | yes |
| <a name="input_secret_arn"></a> [secret\_arn](#input\_secret\_arn) | ARN of the secret to rotate | `string` | n/a | yes |
| <a name="input_security_group_ids"></a> [security\_group\_ids](#input\_security\_group\_ids) | Security groups which the rotation function should use | `list(string)` | `[]` | no |
| <a name="input_source_file"></a> [source\_file](#input\_source\_file) | File containing the rotatation handler | `string` | n/a | yes |
| <a name="input_subnet_ids"></a> [subnet\_ids](#input\_subnet\_ids) | Subnets in which this function should run | `list(string)` | `[]` | no |
| <a name="input_variables"></a> [variables](#input\_variables) | Environment variables for the rotation function | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_arn"></a> [arn](#output\_arn) | ARN of the function which will rotate this secret |
<!-- END_TF_DOCS -->
