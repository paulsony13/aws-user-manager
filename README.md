# AWS User Manager Terraform Module

## Overview
This Terraform module automates the onboarding of AWS users by creating IAM roles with the necessary permissions. It supports role-based access control (RBAC) and cross-account role assumptions, ensuring a scalable and secure approach to managing user access within multiple AWS accounts without using AWS Orginizations .

## Features
- **Automated IAM Role Creation**: Assigns unique IAM roles for each user.
- **Cross-Account Role Assumption**: Enables secure access to multiple AWS accounts.
- **Policy-Based Access Control**: Users receive only the permissions they need.
- **Terraform-Based Automation**: Ensures consistency and repeatability.

## Prerequisites
- Terraform 1.0+
- AWS CLI configured with necessary permissions
- AWS SSO integration (if applicable)

## Usage

# Landing AWS account role creation
```hcl
module "aws_landing_main_role" {
  source          = "github.com/paulsony13/aws-user-manager//modules/main-roles"
  users           = var.users
  main_account_id = "123456789012"
}
```
# child AWS account role creation
```hcl
module "assume_role_aws_account1" {
  source          = "github.com/paulsony13/aws-user-manager//modules/assume-roles"
  users     = var.users
  accountId = "<account-id-1>"
  providers = {
    aws = aws.awsAccount1
  }
}
```

## Inputs
| Name            | Type        | Description |
|----------------|------------|-------------|
| `mainAccountId` | `string`   | AWS account ID for the main authentication account |
| `users`        | `list`      | List of user objects containing usernames and account assignments |

## Outputs
| Name               | Description |
|--------------------|-------------|
| `iam_role_names`   | List of created IAM role names |
| `policy_arns`      | List of policy ARNs attached to each user role |

## Deployment Steps
1. Clone the repository:
   ```sh
   git clone https://github.com/paulsony13/aws-user-manager.git
   ```
   update the providers and add as many as child accounts you want
2. Initialize Terraform:
   ```sh
   terraform init
   ```
3. Review and apply the configuration:
   ```sh
   terraform apply -auto-approve
   ```

## Security Best Practices
- Use AWS SSO for authentication instead of IAM users.
- Follow the principle of least privilege when assigning policies.
- Regularly audit IAM roles and permissions.

## License
This module is released under the MIT License.

## Contributions
Feel free to contribute by submitting issues or pull requests.
