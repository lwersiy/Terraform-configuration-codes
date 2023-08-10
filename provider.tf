terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.10.0"
    }



  }
}


provider "aws" {
  region  = "us-east-2"
  profile = "default"
}

provider "github" {
  token = ""
}

provider "random" = {
      source  = "hashicorp/random"
      version = "3.1.0"
    }

    
provider "kubernetes" = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.0.1"
    }