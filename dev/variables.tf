variable "environment" {
  description = "Environment type (dev/stage/prod)"
  type        = string
  default     = "dev"
}

variable "eks_version" {
  description = "EKS Kubernetes version"
  type        = string
  default     = "1.32"
}

variable "eks_module_version" {
  description = "Terraform EKS module version"
  type        = string
  default     = "20.33.1"
}

variable "vpc_module_version" {
  description = "Terraform VPC module version"
  type        = string
  default     = "5.18.1"
}