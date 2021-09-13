# Generic Secret

Creates an AWS Secrets Manager secret without automatic rotation.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.14.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 3.45 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 3.45 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_iam_policy.read_secret](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.rotation](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role.rotation](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.rotation](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_kms_alias.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_alias) | resource |
| [aws_kms_key.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_key) | resource |
| [aws_secretsmanager_secret.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secret) | resource |
| [aws_secretsmanager_secret_policy.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secret_policy) | resource |
| [aws_secretsmanager_secret_version.initial](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secret_version) | resource |
| [aws_caller_identity.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_iam_policy_document.key](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.read_secret](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.rotation](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.rotation_assume_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.secret](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_region.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_description"></a> [description](#input\_description) | Description for this secret | `string` | `null` | no |
| <a name="input_initial_value"></a> [initial\_value](#input\_initial\_value) | Initial value for this secret | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | Name for this secret | `string` | n/a | yes |
| <a name="input_resource_tags"></a> [resource\_tags](#input\_resource\_tags) | Tags to be applied to created resources | `map(string)` | `{}` | no |
| <a name="input_rotation_trust_policy"></a> [rotation\_trust\_policy](#input\_rotation\_trust\_policy) | Overrides for the rotation role trust policy | `string` | `null` | no |
| <a name="input_secret_policy"></a> [secret\_policy](#input\_secret\_policy) | Overrides for the secret resource policy | `string` | `null` | no |
| <a name="input_trust_principal"></a> [trust\_principal](#input\_trust\_principal) | Principal allowed to access the secret (default: current account) | `string` | `null` | no |
| <a name="input_trust_tags"></a> [trust\_tags](#input\_trust\_tags) | Tags required on principals accessing the secret | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_arn"></a> [arn](#output\_arn) | ARN of the created secret |
| <a name="output_name"></a> [name](#output\_name) | Name of the created secret |
| <a name="output_policy_arn"></a> [policy\_arn](#output\_policy\_arn) | ARN of the policy created for consuming this secret |
| <a name="output_rotation_role_arn"></a> [rotation\_role\_arn](#output\_rotation\_role\_arn) | ARN of the IAM role allowed to rotate this secret |
| <a name="output_rotation_role_name"></a> [rotation\_role\_name](#output\_rotation\_role\_name) | Name of the IAM role allowed to rotate this secret |
<!-- END_TF_DOCS -->