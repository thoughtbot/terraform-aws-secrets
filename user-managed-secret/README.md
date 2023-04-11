# User Managed Secret

Creates an [AWS Secrets Manager] which is expected to be manually updated by a
developer. A list of environment variable names can be provided, which must then
be filled in using the SecretsManager UI or CLI. Rotation is disabled for the
secret.

Example:

``` terraform
module "smtp" {
  source = "github.com/thoughtbot/terraform-aws-secrets//secret"

  environment_variables = ["USERNAME", "PASSWORD"]
  description           = "SMTP credentials"
  name                  = "smtp-credentials"
}
```

This module does not support rotation, but it otherwise supports the same
variables for permissions as the [generic secret module].

[AWS Secrets Manager]: https://docs.aws.amazon.com/secretsmanager/latest/userguide/intro.html
[KMS]: https://docs.aws.amazon.com/kms/latest/developerguide/overview.html
[generic secret module]: ../secret

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.14.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_secret"></a> [secret](#module\_secret) | ../secret | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_admin_principals"></a> [admin\_principals](#input\_admin\_principals) | Principals allowed to peform admin actions (default: current account) | `list(string)` | `null` | no |
| <a name="input_description"></a> [description](#input\_description) | Description for this secret | `string` | `null` | no |
| <a name="input_environment_variables"></a> [environment\_variables](#input\_environment\_variables) | Environment variables for which a user must provide values | `list(string)` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | Name for this secret | `string` | n/a | yes |
| <a name="input_read_principals"></a> [read\_principals](#input\_read\_principals) | Principals allowed to read the secret (default: current account) | `list(string)` | `null` | no |
| <a name="input_readwrite_principals"></a> [readwrite\_principals](#input\_readwrite\_principals) | Principals allowed to both read and write secrets | `list(string)` | `[]` | no |
| <a name="input_resource_tags"></a> [resource\_tags](#input\_resource\_tags) | Tags to be applied to created resources | `map(string)` | `{}` | no |
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
| <a name="output_secret_name"></a> [secret\_name](#output\_secret\_name) | Name of the created secret |
<!-- END_TF_DOCS -->
