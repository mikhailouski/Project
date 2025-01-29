resource "aws_ecr_repository" "main" {
  name                 = "yuri-${var.environment}-ecr-repo"
  image_tag_mutability = "MUTABLE"
}