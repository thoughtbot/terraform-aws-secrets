resource "aws_secretsmanager_secret" "this" {
  description = var.description
  kms_key_id  = aws_kms_key.this.arn
  name        = var.name
  tags        = var.resource_tags
}

resource "aws_secretsmanager_secret_policy" "this" {
  secret_arn = aws_secretsmanager_secret.this.arn
  policy     = data.aws_iam_policy_document.secret.json
}

data "aws_iam_policy_document" "secret" {
  override_json = var.secret_policy

  statement {
    sid       = "AllowRotation"
    resources = ["*"]
    actions = [
      "secretsmanager:DescribeSecret",
      "secretsmanager:GetSecretValue",
      "secretsmanager:PutSecretValue",
      "secretsmanager:UpdateSecretVersionStage"
    ]
    principals {
      type        = "AWS"
      identifiers = [aws_iam_role.rotation.arn]
    }
  }

  statement {
    sid       = "AllowRead"
    resources = ["*"]
    actions = [
      "secretsmanager:DescribeSecret",
      "secretsmanager:GetSecretValue",
    ]
    principals {
      type        = "AWS"
      identifiers = [local.trust_principal]
    }
    dynamic "condition" {
      for_each = var.trust_tags

      content {
        test     = "StringEquals"
        variable = "aws:PrincipalTag/${condition.key}"
        values   = [condition.value]
      }
    }
  }
}

resource "aws_secretsmanager_secret_version" "initial" {
  secret_id     = aws_secretsmanager_secret.this.id
  secret_string = var.initial_value

  lifecycle {
    ignore_changes = [secret_string]
  }
}

resource "aws_kms_key" "this" {
  description         = var.name
  enable_key_rotation = true
  policy              = data.aws_iam_policy_document.key.json
  tags                = var.resource_tags
}

resource "aws_kms_alias" "this" {
  name          = "alias/${var.name}"
  target_key_id = aws_kms_key.this.arn
}

data "aws_iam_policy_document" "key" {
  statement {
    sid = "AllowManagement"
    not_actions = [
      "kms:Encrypt",
      "kms:Decrypt",
      "kms:ReEncrypt*",
      "kms:GenerateDataKey*"
    ]
    resources = ["*"]
    principals {
      identifiers = [local.account_arn]
      type        = "AWS"
    }
  }

  statement {
    sid = "AllowRotation"
    actions = [
      "kms:Encrypt",
      "kms:Decrypt",
      "kms:ReEncrypt*",
      "kms:GenerateDataKey*"
    ]
    resources = ["*"]
    principals {
      type        = "AWS"
      identifiers = [aws_iam_role.rotation.arn]
    }
  }

  statement {
    sid = "AllowSecretsManager"
    actions = [
      "kms:Encrypt",
      "kms:Decrypt",
      "kms:ReEncrypt*",
      "kms:GenerateDataKey*"
    ]
    resources = ["*"]
    principals {
      identifiers = [local.trust_principal]
      type        = "AWS"
    }
    condition {
      test     = "StringEquals"
      variable = "kms:ViaService"
      values   = ["secretsmanager.${local.region}.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "read_secret" {
  statement {
    sid = "ReadSecret${local.sid_suffix}"
    actions = [
      "secretsmanager:DescribeSecret",
      "secretsmanager:GetSecretValue"
    ]
    resources = [aws_secretsmanager_secret.this.arn]
  }

  statement {
    sid = "DecryptSecret${local.sid_suffix}"
    actions = [
      "kms:Decrypt"
    ]
    resources = [aws_kms_key.this.arn]
  }
}

resource "aws_iam_role" "rotation" {
  assume_role_policy = data.aws_iam_policy_document.rotation_assume_role.json
  name               = "${var.name}-rotation"
  tags               = var.resource_tags
}

resource "aws_iam_role_policy_attachment" "rotation" {
  policy_arn = aws_iam_policy.rotation.arn
  role       = aws_iam_role.rotation.id
}

data "aws_iam_policy_document" "rotation_assume_role" {
  override_json = var.rotation_trust_policy

  statement {
    actions = ["sts:AssumeRole"]
    principals {
      identifiers = ["lambda.amazonaws.com"]
      type        = "Service"
    }
  }
}

resource "aws_iam_policy" "rotation" {
  name   = "${var.name}-rotation"
  policy = data.aws_iam_policy_document.rotation.json
  tags   = var.resource_tags
}

data "aws_iam_policy_document" "rotation" {
  statement {
    sid = "ManageSecret"
    actions = [
      "secretsmanager:DescribeSecret",
      "secretsmanager:GetSecretValue",
      "secretsmanager:PutSecretValue",
      "secretsmanager:UpdateSecretVersionStage"
    ]
    resources = [aws_secretsmanager_secret.this.arn]
  }

  statement {
    sid = "GetRandomPassword"
    actions = [
      "secretsmanager:GetRandomPassword",
    ]
    resources = ["*"]
  }

  statement {
    sid = "UseKey"
    actions = [
      "kms:Encrypt",
      "kms:Decrypt",
      "kms:ReEncrypt*",
      "kms:GenerateDataKey*"
    ]
    resources = [aws_kms_key.this.arn]
  }
}

data "aws_region" "this" {}

data "aws_caller_identity" "this" {}

locals {
  account_arn     = "arn:aws:iam::${local.account_id}:root"
  account_id      = data.aws_caller_identity.this.account_id
  region          = data.aws_region.this.name
  sid_suffix      = join("", regexall("[[:alnum:]]+", var.name))
  trust_principal = coalesce(var.trust_principal, local.account_arn)
}
