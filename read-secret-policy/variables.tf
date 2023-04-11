variable "policy_name" {
  description = "Name of the IAM policy allowed to read secrets"
  type        = string
}

variable "role_names" {
  description = "If provided, an IAM policy will be attached to the given roles"
  type        = list(string)
  default     = []
}

variable "secret_names" {
  description = "Names of SecretsManager secrets the role can read"
  type        = list(string)
}
