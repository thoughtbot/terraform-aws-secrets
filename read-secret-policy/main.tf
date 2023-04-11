resource "aws_iam_policy" "read_secrets" {
  name   = var.policy_name
  policy = data.aws_iam_policy_document.read_secrets.json
}

resource "aws_iam_role_policy_attachment" "read_secrets" {
  for_each = toset(var.role_names)

  policy_arn = aws_iam_policy.read_secrets.arn
  role       = each.value
}

data "aws_secretsmanager_secret" "secrets" {
  for_each = toset(var.secret_names)

  name = each.value
}

data "aws_kms_key" "secrets" {
  for_each = data.aws_secretsmanager_secret.secrets

  key_id = each.value.kms_key_id
}

data "aws_iam_policy_document" "read_secrets" {
  statement {
    sid = "ReadSecrets"
    actions = [
      "secretsmanager:DescribeSecret",
      "secretsmanager:GetSecretValue"
    ]
    resources = values(data.aws_secretsmanager_secret.secrets)[*].arn
  }

  statement {
    sid = "DecryptSecrets"
    actions = [
      "kms:Decrypt"
    ]
    resources = values(data.aws_kms_key.secrets)[*].arn
  }
}
