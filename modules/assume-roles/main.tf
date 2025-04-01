resource "aws_iam_role" "this" {
  for_each = {
    for user in var.users : user.username => {
      username = user.username
      accounts = [for account in user.accounts :
        account if account.account_id == var.accountId
      ]
      } if length([for account in user.accounts :
        account if account.account_id == var.accountId
    ]) > 0
  }
  name = each.value.username
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          AWS = "arn:aws:iam::${var.mainAccountId}:role/${each.value.username}-assume-role"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
  tags = merge(
    {
      Username = each.value.username
    },
    try({ ExpiryDate = each.value.accounts[0].expirydate }, {})
  )
}

resource "aws_iam_role_policy_attachment" "this" {
  for_each   = aws_iam_role.this
  role       = each.value.name
  policy_arn = "arn:aws:iam::aws:policy/ReadOnlyAccess"

  depends_on = [aws_iam_role.this]
}

resource "aws_iam_policy" "deny_create_user" {
  name        = "DenyUserCreation"
  description = "Denies IAM user creation"
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect   = "Deny"
        Action   = "iam:CreateUser" # Deny normal IAM user creation
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "deny_create_user_attachment" {
  for_each   = aws_iam_role.this
  role       = each.value.name
  policy_arn = aws_iam_policy.deny_create_user.arn

  depends_on = [aws_iam_role.this]
}

resource "aws_iam_role_policy_attachment" "managed_policy_attachment" {
  for_each = {
    for idx, attachment in local.policy_attachments :
    "${attachment.role}-${idx}" => attachment
  }
  role       = each.value.role
  policy_arn = "arn:aws:iam::aws:policy/${each.value.policy_arn}"

  depends_on = [aws_iam_role.this]
}

resource "aws_iam_policy" "custom_policies" {
  for_each = {
    for attachment in local.custom_policy_attachments :
    "${attachment.role}-${attachment.policy_name}-${attachment.account_id}" => attachment
  }

  name = "${each.value.policy_name}-${each.value.role}"

  policy = jsonencode(
    lookup(
      jsondecode(file("${path.module}/../../policy_template.json")),
      each.value.policy_name
    )
  )
}

resource "aws_iam_role_policy_attachment" "custom_policy_attachment" {
  for_each = aws_iam_policy.custom_policies

  role       = split("-", each.key)[0]
  policy_arn = each.value.arn
  depends_on = [aws_iam_role.this]
}

