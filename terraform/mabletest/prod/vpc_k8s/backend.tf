terraform {
  backend "s3" {
    bucket         = "mabletest-terraform-st"
    key            = "prod/vpc_k8s/terraform.tfstate"
    region         = "ap-southeast-2"
    profile        = "mabletest"
    dynamodb_table = "mabletest-terraform-st-lock"
    encrypt        = true
  }
}

provider "aws" {
  profile = var.aws_profile
  region  = var.aws_region
}
