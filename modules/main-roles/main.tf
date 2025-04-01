resource "aws_iam_role" "user_roles" {
  for_each = { for user in var.users : user.username => user }

  name = "${each.key}-assume-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Federated = "arn:aws:iam::${var.main_account_id}:saml-provider/SSO-MainAccount"
        }
        Action = "sts:AssumeRoleWithSAML"
        Condition = {
          StringEquals = {
            "SAML:aud" = "https://signin.aws.amazon.com/saml"
          }
        }
      }
    ]
  })
}
resource "aws_iam_policy" "user_assume_policy" {
  for_each = { for user in var.users : user.username => user }

  name        = "${each.key}-assume-role-policy"
  description = "Assume role policy for ${each.key}"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      for account in each.value.accounts : {
        Effect   = "Allow"
        Action   = ["sts:AssumeRole"]
        Resource = "arn:aws:iam::${account.account_id}:role/${each.key}"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "user_role_attachment" {
  for_each = { for user in var.users : user.username => user }

  role       = aws_iam_role.user_roles[each.key].name
  policy_arn = aws_iam_policy.user_assume_policy[each.key].arn
}
