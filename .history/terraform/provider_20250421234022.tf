provider "aws" {
  
}

terraform {
  backend "s3" {
    bucket = "terraform-resources-github-actions"
    region = "us-east-1"
    key = "github-actions/terraform.tfstate"
    encrypt = true
    dynamodb_table = "tf-resources-gha-lock"
  }
}