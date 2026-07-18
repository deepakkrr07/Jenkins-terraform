
terraform {
  required_version = ">= 1.5.7"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 6.20"
    }

    helm = {
      source  = "hashicorp/helm"
      #version = ">= 3.0"
      version = "~> 3.0"
    }

    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.28"
    }
  }


  # Remote backend configuration using S3 
  backend "s3" {
    bucket         = "jenkins-terraform-statefile-1807"         
    key            = "dev/karpenter/terraform.tfstate"            
    region         = "ap-southeast-2"                            
    encrypt        = true                                   
    use_lockfile   = true     
  }
}

provider "aws" {
  # AWS region to use for all resources (from variables)
  region = var.aws_region
}
