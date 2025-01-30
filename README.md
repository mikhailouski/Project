# Kubernetes Infrastructure with Terraform on AWS

## Project Description

This project is designed to deploy a Kubernetes infrastructure (AWS EKS) using Terraform on AWS. The project includes:

- VPC, subnets, and other networking components
- ECR repository for storing Docker images
- EKS cluster with two worker nodes (`t3.micro`)
- S3 bucket for storing the Terraform state file and DynamoDB for state file locking
- CI/CD pipeline for automatic infrastructure deployment using GitHub Actions

## Project Structure

```
.
├── .github/
│   └── workflows/
│       ├── tf-deploy.yml       # Deployment of the main infrastructure
│       ├── tf-destroy-main.yml # Destruction of the main infrastructure
├── base-infrastructure/        # Base infrastructure (S3, DynamoDB, IAM)
│   ├── main.tf
│   ├── iam.tf
│   ├── backend.tf
└── main-infrastructure/        # Main infrastructure (VPC, EKS, ECR)
    ├── main.tf
    ├── ecr.tf
    ├── eks.tf
    ├── vpc.tf
    ├── outputs.tf
    ├── variables.tf
```

## Installation and Setup

### 1. Install Dependencies

Before starting, ensure you have installed:

- [Terraform](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)
- [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2.html)
- [Git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git)

### 2. Configure AWS CLI

```sh
aws configure
```

Provide the following:

- AWS Access Key ID
- AWS Secret Access Key
- AWS Region (e.g., `us-east-1`)

### 3. Deploy Base Infrastructure

Before deploying the main infrastructure, the base infrastructure (S3, DynamoDB, IAM) must be created:

```sh
cd base-infrastructure
terraform init
terraform apply -auto-approve
```

### 4. Deploy Main Infrastructure

```sh
cd main-infrastructure
terraform init
terraform apply -auto-approve
```

## CI/CD (GitHub Actions)

### Infrastructure Deployment

With every `push` to the `dev` branch, the GitHub Actions workflow `.github/workflows/tf-deploy.yml` is triggered, which:

1. Configures AWS CLI
2. Initializes Terraform
3. Executes `terraform plan` and `terraform apply`

### Infrastructure Destruction

Infrastructure destruction is manually triggered via the GitHub Actions workflow `.github/workflows/tf-destroy-main.yml`. To proceed, you must enter `destroy` as confirmation.

## Terraform Outputs

After successful execution of `terraform apply`, the following outputs will be available:

- **VPC ID**
- **EKS Cluster and API endpoint**
- **ECR Repository URL**
- **Command to configure `kubectl`**

## Managing the EKS Cluster

After deployment, configure `kubectl`:

```sh
aws eks --region us-east-1 update-kubeconfig --name yuri-dev-cluster
kubectl get nodes
```

