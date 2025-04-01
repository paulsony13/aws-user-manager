terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}
provider "aws" {
  region = "us-east-1"
}

provider "aws" {
  alias  = "awsAccount1"
  region = "us-east-1"
  assume_role {
    role_arn = "arn:aws:iam::<>:role/TerraformExecutionRole"
  }
}

provider "aws" {
  alias  = "awsAccount2"
  region = "us-east-1"
  assume_role {
    role_arn = "arn:aws:iam::<>:role/TerraformExecutionRole"
  }
}