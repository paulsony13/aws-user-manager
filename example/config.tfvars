users = [
  {
    username = "user1@example.com",
    accounts = [
      {
        account_id       = "aws-account-id-1"
        awsmanagedpolicy = ["AdministratorAccess"]
        custom_policy    = []
      },
      {
        account_id       = "aws-account-id-1"
        awsmanagedpolicy = ["AdministratorAccess"]
        custom_policy    = []
      },
    ]
  },
  {
    username = "user2@example.com",
    accounts = [
      {
        account_id       = "aws-account-id-4"
        awsmanagedpolicy = ["AdministratorAccess"]
        custom_policy    = ["ECSReadPolicyDescribe","<any more based on the policytemaplete.json>"]
      },

    ]
  },
]
mainAccountId = "123456789012"