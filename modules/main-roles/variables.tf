variable "users" {
  description = "List of users with their account details"
  type = list(object({
    username = string
    accounts = list(object({
      account_id = string
    }))
  }))
}

variable "main_account_id" {
  description = "AWS main account ID for SAML federation"
  type        = string
}