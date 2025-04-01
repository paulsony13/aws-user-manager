terraform {
  backend "s3" {
    bucket         = "<your-bucket-name>"
    key            = "state/terraform.tfstate"
    region         = "<aws-region>"
  }
}