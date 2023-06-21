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
    sid = "AllowAdmin"
    not_actions = [
      "kms:Encrypt",
      "kms:Decrypt",
      "kms:ReEncrypt*",
      "kms:GenerateDataKey*"
    ]
    resources = ["*"]
    principals {
      identifiers = local.admin_principals
      type        = "AWS"
    }
  }
}

data "aws_iam_policy_document" "read_secret" {
  statement {
    sid = "DecryptSecret${local.sid_suffix}"
    actions = [
      "kms:Decrypt"
    ]
    resources = [aws_kms_key.this.arn]
  }
}

data "aws_caller_identity" "this" {}

locals {
  account_arn      = "arn:aws:iam::${local.account_id}:root"
  account_id       = data.aws_caller_identity.this.account_id
  sid_suffix       = join("", regexall("[[:alnum:]]+", var.name))
  admin_principals = [local.account_arn]
}
