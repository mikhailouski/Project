terraform {
  required_version = ">= 1.10.5"
  backend "local" {} # Using local state file initially
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

resource "aws_iam_role" "github_actions_yuri" {
  name = "github-actions-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        Federated = "arn:aws:iam::443370672158:oidc-provider/token.actions.githubusercontent.com"
      }
      Action = "sts:AssumeRoleWithWebIdentity"
      Condition = {
        StringLike = {
          "token.actions.githubusercontent.com:sub" = "repo:mikhailouski/project:*"
        }
      }
    }]
  })
}

resource "aws_iam_role_policy" "terraform_access" {
  name = "terraform-state-access"
  role = aws_iam_role.github_actions_yuri.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "s3:*",
          "dynamodb:*",
          "eks:*",
          "ecr:*",
          "iam:*",
          "vpc:*"
        ]
        Resource = "*"
      }
    ]
  })
}

output "role_arn" {
  value = aws_iam_role.github_actions_yuri.arn
}