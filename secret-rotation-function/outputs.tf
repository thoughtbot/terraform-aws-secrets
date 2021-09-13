output "arn" {
  description = "ARN of the function which will rotate this secret"
  value       = aws_lambda_function.rotation.arn
}
