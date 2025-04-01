variable "users" {
  description = "List of users and their properties"
  type = list(object({
    username   = string
    sns_member = optional(bool, false)
    accounts = list(object({
      account_id       = string
      awsmanagedpolicy = optional(list(string))
      custom_policy    = optional(list(string))
      expirydate       = optional(string)
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