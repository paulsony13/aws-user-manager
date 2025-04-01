locals {
  policy_attachments = flatten([
    for user in var.users : [
      for account in user.accounts : [
        for policy in account.awsmanagedpolicy : {
          role       = user.username
          policy_arn = policy
        }
        if account.account_id == var.accountId
      ]
    ]
  ])

  custom_policy_attachments = flatten([
    for user in var.users : [
      for account in user.accounts : [
        for policy_name in account.custom_policy : {
          role        = user.username
          policy_name = policy_name
          account_id  = account.account_id
        }
        if account.account_id == var.accountId
      ]
    ]
  ])
}
