# Used after initial creation of S3 Bucket
terraform {
  backend "s3" {
    bucket         = "yuri-tf-state-bucket"
    key            = "base/dev/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "yuri-terraform-locks"
    encrypt        = true
  }
}