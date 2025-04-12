terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}
provider "aws" {
  profile = "default"
  region  = "ap-southeast-1"
}

# Referencing frontend module
module "frontend" {
  source = "./modules/frontend"
}

# Referencing backend module
module "backend" {
  source = "./modules/backend"
}