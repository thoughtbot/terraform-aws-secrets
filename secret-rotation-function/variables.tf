variable "rotation_days" {
  description = "Number of days after which the secret is rotated"
  type        = number
  default     = 30
}

variable "role_arn" {
  description = "ARN of the IAM role capable of rotating the secret"
  type        = string
}

variable "variables" {
  description = "Environment variables for the rotation function"
  type        = map(string)
  default     = {}
}

variable "handler" {
  description = "Handler to invoke in the function package"
  type        = string
}

variable "runtime" {
  description = "Runtime of the rotation function"
  type        = string
}

variable "secret_arn" {
  description = "ARN of the secret to rotate"
  type        = string
}

variable "security_group_ids" {
  description = "Security groups which the rotation function should use"
  type        = list(string)
}

variable "source_file" {
  description = "File containing the rotatation handler"
  type        = string
}

variable "subnet_ids" {
  description = "Subnets in which this function should run"
  type        = list(string)
}
