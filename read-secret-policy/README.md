# Secret Read Policy

This module creates an IAM policy which allows the principal to read a given
list of secrets from [AWS Secrets Manager]. It also allows decryption using the
KMS key attached to each secret.

Example:

``` hcl
module "secret_read_policy" {
  source = "github.com/thoughtbot/terraform-aws-secrets//secret-read-policy"

  policy_name = "example-read-secrets"

  # If provided, the IAM policy will attached to the given roles
  role_names = ["example-service"]

  secrets_manager_secrets = [
    "rds-postgres-example"
    "ses-smtp"
    "rds-postgres-replica"
  ]
}
```

[AWS Secrets Manager]: https://docs.aws.amazon.com/secretsmanager/latest/userguide/intro.html

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.15.5 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 5.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 5.0 |

## Resources

| Name | Type |
|------|------|
| [aws_iam_policy.read_secrets](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role_policy_attachment.read_secrets](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_policy_document.read_secrets](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_kms_key.secrets](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/kms_key) | data source |
| [aws_secretsmanager_secret.secrets](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/secretsmanager_secret) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_policy_name"></a> [policy\_name](#input\_policy\_name) | Name of the IAM policy allowed to read secrets | `string` | n/a | yes |
| <a name="input_role_names"></a> [role\_names](#input\_role\_names) | If provided, an IAM policy will be attached to the given roles | `list(string)` | `[]` | no |
| <a name="input_secret_names"></a> [secret\_names](#input\_secret\_names) | Names of SecretsManager secrets the role can read | `list(string)` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_policy_arn"></a> [policy\_arn](#output\_policy\_arn) | ARN of the IAM policy created to grant secrets |
| <a name="output_policy_attachments"></a> [policy\_attachments](#output\_policy\_attachments) | Role attachments for the created IAM policy |
| <a name="output_policy_json"></a> [policy\_json](#output\_policy\_json) | IAM policy granting read access to these secrets |
<!-- END_TF_DOCS -->
