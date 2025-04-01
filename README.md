# AWS User Manager Terraform Module

## Overview
This Terraform module automates the onboarding of AWS users by creating IAM roles with the necessary permissions. It supports role-based access control (RBAC) and cross-account role assumptions, ensuring a scalable and secure approach to managing user access within an AWS Organization.

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

```hcl
module "aws_user_manager" {
  source          = "github.com/paulsony13/aws-user-manager"
  mainAccountId   = "123456789012"
  users = [
    {
      username = "aws.admin@example.com"
      accounts = [
        {
          account_id        = "987654321098"
          awsmanagedpolicy  = ["arn:aws:iam::aws:policy/ReadOnlyAccess"]
          custom_policy     = ["customPolicyDocument"]
        }
      ]
    }
  ]
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
