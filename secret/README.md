# Generic Secret

Creates an [AWS Secrets Manager] secret with an initial value. A unique [KMS] is
key is created with a policy that allows consumers to decrypt and allows the
rotation function to encrypt.

Example:

``` terraform
module "auth_token" {
  source = "github.com/thoughtbot/terraform-aws-secrets//secret"

  description   = "Auth token for managing client keys"
  initial_value = random_string.auth_token.result
  name          = "auth-token"
}
```

## Permissions

You can provide administrative and consumer principals:

``` terraform
admin_principals = [data.aws_iam_role.sso_admin_user.arn]
read_principals  = [aws_iam_role.myservice.arn]
```

If you don't provide principals, permissions will be delegated to IAM, meaning
that any user or role with the correct `secretsmanager:*` permissions will be
able to use the secret.

You can also implement tag-based ABAC by providing trust tags:

``` terraform
trust_tags = { Service = "myservice" }
```

This will include a condition in the trust policy that denies reading unless the
principal has the corresponding tags.

## Automatic Rotation

Rotation is not configured, but a role suitable for a rotation function is
created and available in the outputs. You can create your own rotation function
using the [secret rotation function module].

[AWS Secrets Manager]: https://docs.aws.amazon.com/secretsmanager/latest/userguide/intro.html
[KMS]: https://docs.aws.amazon.com/kms/latest/developerguide/overview.html
[secret rotation function module]: ../secret-rotation-function

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.15.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 5.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 5.0 |

## Resources

| Name | Type |
|------|------|
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
| [aws_iam_role.rotation](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_role) | data source |
| [aws_region.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_admin_principals"></a> [admin\_principals](#input\_admin\_principals) | Principals allowed to peform admin actions (default: current account) | `list(string)` | `null` | no |
| <a name="input_create_rotation_policy"></a> [create\_rotation\_policy](#input\_create\_rotation\_policy) | Set to false to disable creation of an IAM policy for rotation | `bool` | `true` | no |
| <a name="input_create_rotation_role"></a> [create\_rotation\_role](#input\_create\_rotation\_role) | Set to false to use an existing IAM role for rotation | `bool` | `true` | no |
| <a name="input_description"></a> [description](#input\_description) | Description for this secret | `string` | `null` | no |
| <a name="input_initial_value"></a> [initial\_value](#input\_initial\_value) | Initial value for this secret | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | Name for this secret | `string` | n/a | yes |
| <a name="input_read_principals"></a> [read\_principals](#input\_read\_principals) | Principals allowed to read the secret (default: current account) | `list(string)` | `null` | no |
| <a name="input_readwrite_principals"></a> [readwrite\_principals](#input\_readwrite\_principals) | Principals allowed to both read and write secrets | `list(string)` | `[]` | no |
| <a name="input_resource_tags"></a> [resource\_tags](#input\_resource\_tags) | Tags to be applied to created resources | `map(string)` | `{}` | no |
| <a name="input_rotation_role_name"></a> [rotation\_role\_name](#input\_rotation\_role\_name) | Override the name for the rotation role | `string` | `null` | no |
| <a name="input_rotation_trust_policies"></a> [rotation\_trust\_policies](#input\_rotation\_trust\_policies) | Overrides for the rotation role trust policies | `list(string)` | `[]` | no |
| <a name="input_secret_policies"></a> [secret\_policies](#input\_secret\_policies) | Overrides for the secret resource policies | `list(string)` | `[]` | no |
| <a name="input_trust_tags"></a> [trust\_tags](#input\_trust\_tags) | Tags required on principals accessing the secret | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_arn"></a> [arn](#output\_arn) | ARN of the created secret |
| <a name="output_environment_variables"></a> [environment\_variables](#output\_environment\_variables) | Environment variables provided by this secret |
| <a name="output_id"></a> [id](#output\_id) | Id of the created secret |
| <a name="output_kms_key_alias"></a> [kms\_key\_alias](#output\_kms\_key\_alias) | Alias of the KMS key encrypting the secret |
| <a name="output_kms_key_arn"></a> [kms\_key\_arn](#output\_kms\_key\_arn) | Alias of the KMS key encrypting the secret |
| <a name="output_name"></a> [name](#output\_name) | Name of the created secret |
| <a name="output_policy_json"></a> [policy\_json](#output\_policy\_json) | Policy json for consuming this secret |
| <a name="output_rotation_role_arn"></a> [rotation\_role\_arn](#output\_rotation\_role\_arn) | ARN of the IAM role allowed to rotate this secret |
| <a name="output_rotation_role_name"></a> [rotation\_role\_name](#output\_rotation\_role\_name) | Name of the IAM role allowed to rotate this secret |
| <a name="output_secret_name"></a> [secret\_name](#output\_secret\_name) | Name of the created secret |
<!-- END_TF_DOCS -->
