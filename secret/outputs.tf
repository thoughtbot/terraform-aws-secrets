output "arn" {
  description = "ARN of the created secret"
  value       = aws_secretsmanager_secret.this.arn
}

output "name" {
  description = "Name of the created secret"
  value       = aws_secretsmanager_secret.this.name
}

output "policy_arn" {
  description = "ARN of the policy created for consuming this secret"
  value       = aws_iam_policy.read_secret.arn
}

output "rotation_role_arn" {
  description = "ARN of the IAM role allowed to rotate this secret"
  value       = aws_iam_role.rotation.arn
}

output "rotation_role_name" {
  description = "Name of the IAM role allowed to rotate this secret"
  value       = aws_iam_role.rotation.name
}
