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

resource "random_password" "this" {
  for_each = toset(var.environment_variables)

  lower       = try(var.random_settings[each.value].lower, true)
  min_lower   = try(var.random_settings[each.value].min_lower, 0)
  min_numeric = try(var.random_settings[each.value].min_numeric, 0)
  min_special = try(var.random_settings[each.value].min_special, 0)
  min_upper   = try(var.random_settings[each.value].min_upper, 0)
  length      = try(var.random_settings[each.value].length, 32)
  numeric     = try(var.random_settings[each.value].numeric, true)
  special     = try(var.random_settings[each.value].special, false)
  upper       = try(var.random_settings[each.value].upper, true)

  override_special = try(
    var.random_settings[each.value].override_special,
    false
  )
}

locals {
  initial_value = zipmap(
    var.environment_variables,
    [for key in var.environment_variables : random_password.this[key].result]
  )
}
