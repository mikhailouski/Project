resource "aws_ecr_repository" "main" {
  name                 = "yuri-${var.environment}-ecr-repo"
  image_tag_mutability = "MUTABLE"

}

resource "aws_ecr_lifecycle_policy" "main" {
  repository = aws_ecr_repository.main.name

  policy = jsonencode({
    rules = [{
      rulePriority = 1
      description  = "Keep last 30 images"
      action       = { type = "expire" }
      selection    = {
        tagStatus   = "any"
        countType   = "imageCountMoreThan"
        countNumber = 30
      }
    }]
  })
}