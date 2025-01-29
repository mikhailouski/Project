module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = var.eks_module_version
  
  cluster_name    = "yuri-${var.environment}-cluster"
  cluster_version = var.eks_version
  
  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets
  
  eks_managed_node_groups = {
    default = {
      min_size     = 2
      max_size     = 2
      desired_size = 2
      instance_types = ["t3.micro"]
    }
  }
}