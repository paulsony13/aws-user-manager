module "main-roles" {
  source          = "github.com/paulsony13/aws-user-manager//modules/main-roles"
  users           = var.users
  main_account_id = var.mainAccountId
}

module "AWSAccount1" {
  source    = "github.com/paulsony13/aws-user-manager//modules/assume-roles"
  users     = var.users
  accountId = "<account-id-1>"
  providers = {
    aws = aws.awsAccount1
  }
}
module "AWSAccount2" {
  source    = "github.com/paulsony13/aws-user-manager//modules/assume-roles"
  users     = var.users
  accountId = "<account-id-2>"
  providers = {
    aws = aws.awsAccount2
  }
}

# module "AWSAccount3" {
#   source    = "github.com/paulsony13/aws-user-manager//modules/assume-roles"
#   users     = var.users
#   accountId = "<account-id-3>"
#   providers = {
#     aws = aws.awsAccount3
#   }
# }
