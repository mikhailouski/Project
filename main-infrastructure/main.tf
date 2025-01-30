provider "aws" {
  region = var.region
  
  default_tags {
    tags = {
      Environment = var.environment
      Terraform   = "true"
    }
  }
}

terraform {
  backend "s3" {
    bucket         = "yuri-tf-state-bucket"
    key            = "main/dev/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "yuri-terraform-locks"
    encrypt        = true
  }
}