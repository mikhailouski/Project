output "vpc_id" {
  description = "ID of the created VPC"
  value       = module.vpc.vpc_id
}

output "eks_cluster_name" {
  description = "EKS cluster name"
  value       = module.eks.cluster_name
}

output "eks_cluster_endpoint" {
  description = "EKS cluster API endpoint"
  value       = module.eks.cluster_endpoint
}

output "ecr_repository_url" {
  description = "ECR repository URL"
  value       = aws_ecr_repository.main.repository_url
}

output "configure_kubectl" {
  description = "Command to configure kubectl access"
  value       = "aws eks --region us-east-1 update-kubeconfig --name ${module.eks.cluster_name}"
}

output "worker_node_iam_role" {
  description = "IAM role name for worker nodes"
  value       = module.eks.eks_managed_node_groups["default"].iam_role_name
}