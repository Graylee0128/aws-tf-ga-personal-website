provider "aws" {
  
}

terraform {
  backend "s3" {
    bucket = "terraform-resources-github-actions"
  }
}