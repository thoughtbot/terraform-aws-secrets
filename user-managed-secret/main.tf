module "secret" {
  source = "../secret"

  admin_principals       = var.admin_principals
  create_rotation_role   = false
  create_rotation_policy = false
  initial_value          = jsonencode(local.initial_value)
  description            = var.description
  name                   = var.name
  read_principals        = var.read_principals
  readwrite_principals   = var.readwrite_principals
  resource_tags          = var.resource_tags
  secret_policies        = var.secret_policies
  trust_tags             = var.trust_tags
}

locals {
  initial_value = zipmap(
    var.environment_variables,
    [for key in var.environment_variables : ""]
  )
}
