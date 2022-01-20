variable "admin_principals" {
  description = "Principals allowed to peform admin actions (default: current account)"
  type        = list(string)
  default     = null
}

variable "initial_value" {
  description = "Initial value for this secret"
  type        = string
}

variable "description" {
  description = "Description for this secret"
  type        = string
  default     = null
}

variable "name" {
  description = "Name for this secret"
  type        = string
}

variable "read_principals" {
  description = "Principals allowed to read the secret (default: current account)"
  type        = list(string)
  default     = null
}

variable "resource_tags" {
  description = "Tags to be applied to created resources"
  type        = map(string)
  default     = {}
}

variable "rotation_trust_policy" {
  description = "Overrides for the rotation role trust policy"
  type        = string
  default     = null
}

variable "secret_policy" {
  description = "Overrides for the secret resource policy"
  type        = string
  default     = null
}

variable "trust_tags" {
  description = "Tags required on principals accessing the secret"
  type        = map(string)
  default     = {}
}
