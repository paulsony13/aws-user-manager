# Define a variable for user inputs
variable "users" {
  description = "List of users and their account-specific configurations"
  type = list(object({
    username = string
    accounts = list(object({
      account_id        = optional(string)
      awsmanagedpolicy = optional(list(string))
      custom_policy     = optional(list(string))
      expirydate        = optional(string)
    }))
  }))
}
variable "accountId" {
  description = "The AWS account ID where the roles will be created"
  type        = string
}
variable "mainAccountId" {
  description = "The AWS account ID of the landing account"
  type        = string
}

 
