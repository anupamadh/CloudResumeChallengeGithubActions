terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}
provider "aws" {
  profile = "prod"
  region  = "ap-southeast-1"
}

# Referencing frontend module
module "frontend" {
  source = "./modules/frontend"
  cf_id = module.frontend.cf_id
}

# Referencing backend module
module "backend" {
  source = "./modules/backend"
}