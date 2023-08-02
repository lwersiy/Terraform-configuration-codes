terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.10.0"
    }



  }
}


provider "aws" {
  region     = "us-east-1"
  access_key = "AKIA6M2BBVHI6IGDAG7Z"
  secret_key = "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"
}

provider "github" {
  token = "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"
}

