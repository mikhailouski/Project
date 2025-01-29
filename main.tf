provider "aws" {
  region = "us-east-1"
}

terraform {
  backend "s3" {
    bucket         = "yuri-tf-state-bucket"
    key            = "dev/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "yuri-terraform-locks"
    encrypt        = true
  }
}