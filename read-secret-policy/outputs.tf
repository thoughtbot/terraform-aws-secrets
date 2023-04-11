output "policy_json" {
  description = "IAM policy granting read access to these secrets"
  value       = data.aws_iam_policy_document.read_secrets.json
}

output "policy_arn" {
  description = "ARN of the IAM policy created to grant secrets"
  value       = aws_iam_policy.read_secrets.arn
}

output "policy_attachments" {
  description = "Role attachments for the created IAM policy"
  value       = values(aws_iam_role_policy_attachment.read_secrets)[*].id
}
