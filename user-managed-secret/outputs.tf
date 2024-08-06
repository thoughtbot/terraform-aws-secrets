output "arn" {
  description = "ARN of the created secret"
  value       = module.secret.arn
}

output "environment_variables" {
  description = "Environment variables provided by this secret"
  value       = var.environment_variables
}

output "id" {
  description = "Id of the created secret"
  value       = module.secret.id
}

output "kms_key_alias" {
  description = "Alias of the KMS key encrypting the secret"
  value       = module.secret.kms_key_alias
}

output "kms_key_arn" {
  description = "Alias of the KMS key encrypting the secret"
  value       = module.secret.kms_key_arn
}

output "name" {
  description = "Name of the created secret"
  value       = module.secret.name
}

output "policy_json" {
  description = "Policy json for consuming this secret"
  value       = module.secret.policy_json
}

output "secret_name" {
  description = "Name of the created secret"
  value       = module.secret.secret_name
}
