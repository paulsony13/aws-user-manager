module "main-roles" {
  source          = "./modules/main-roles"
  users           = var.users
  main_account_id = var.mainAccountId
}

module "AWSAccount1" {
  source    = "./modules/assume-roles"
  users     = var.users
  accountId = "<account-id-1>"
  providers = {
    aws = aws.awsAccount1
  }
}
module "AWSAccount2" {
  source    = "./modules/assume-roles"
  users     = var.users
  accountId = "<account-id-2>"
  providers = {
    aws = aws.awsAccount2
  }
}

# module "AWSAccount3" {
#   source    = "./modules/assume-roles"
#   users     = var.users
#   accountId = "<account-id-3>"
#   providers = {
#     aws = aws.awsAccount3
#   }
# }
