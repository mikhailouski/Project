terraform {
  required_version = ">= 1.10.5"
  backend "local" {}
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_s3_bucket" "tf_state" {
  bucket = "yuri-tf-state-bucket"
}

resource "aws_dynamodb_table" "tf_locks" {
  name         = "yuri-terraform-locks"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}