module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "20.33.1"
  
  cluster_name    = "yuri-${var.environment}-cluster"
  cluster_version = "1.32"
  
  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets

  eks_managed_node_group_defaults = {
    ami_type       = "AL2_x86_64"
    instance_types = ["t3.micro"]
    iam_role_additional_policies = {
      AmazonEC2ContainerRegistryReadOnly = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
    }
  }
  
  eks_managed_node_groups = {
    yuri-worker-node = {
      min_size     = 2
      max_size     = 2
      desired_size = 2      

      tags = {
        NodeGroup = "yuri-worker-node"
      }    
    }
  }
}