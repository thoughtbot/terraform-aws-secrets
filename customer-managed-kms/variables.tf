variable "name" {
  description = "Unique name for this kms key"
  type        = string
}

variable "resource_tags" {
  description = "Tags to be applied to created resources"
  type        = map(string)
  default     = {}
}
