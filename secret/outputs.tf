output "arn" {
  description = "ARN of the created secret"
  value       = aws_secretsmanager_secret.this.arn
}

output "kms_key_alias" {
  description = "Alias of the KMS key encrypting the secret"
  value       = aws_kms_alias.this.name
}

output "kms_key_arn" {
  description = "Alias of the KMS key encrypting the secret"
  value       = aws_kms_alias.this.arn
}

output "name" {
  description = "Name of the created secret"
  value       = aws_secretsmanager_secret.this.name
}

output "policy_json" {
  description = "Policy json for consuming this secret"
  value       = data.aws_iam_policy_document.read_secret.json
}

output "rotation_role_arn" {
  description = "ARN of the IAM role allowed to rotate this secret"
  value       = aws_iam_role.rotation.arn
}

output "rotation_role_name" {
  description = "Name of the IAM role allowed to rotate this secret"
  value       = aws_iam_role.rotation.name
}

output "id" {
  description = "Id of the created secret"
  value       = aws_secretsmanager_secret.this.id
}
