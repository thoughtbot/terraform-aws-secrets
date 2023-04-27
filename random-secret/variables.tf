variable "admin_principals" {
  description = "Principals allowed to peform admin actions (default: current account)"
  type        = list(string)
  default     = null
}

variable "description" {
  description = "Description for this secret"
  type        = string
  default     = null
}

variable "environment_variables" {
  description = "Environment variables for which a random value should be set"
  type        = list(string)
}

variable "name" {
  description = "Name for this secret"
  type        = string
}

variable "random_settings" {
  description = "Customize random settings for each secret"
  type        = map(any)
  default     = {}
}

variable "read_principals" {
  description = "Principals allowed to read the secret (default: current account)"
  type        = list(string)
  default     = null
}

variable "readwrite_principals" {
  description = "Principals allowed to both read and write secrets"
  type        = list(string)
  default     = []
}

variable "resource_tags" {
  description = "Tags to be applied to created resources"
  type        = map(string)
  default     = {}
}

variable "secret_policies" {
  description = "Overrides for the secret resource policies"
  type        = list(string)
  default     = []
}

variable "trust_tags" {
  description = "Tags required on principals accessing the secret"
  type        = map(string)
  default     = {}
}
