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
  token = "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"
}

