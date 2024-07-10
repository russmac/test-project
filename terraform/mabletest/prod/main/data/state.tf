data "terraform_remote_state" "vpc_data" {
  backend = "s3"
  config = {
    bucket = "${local.mt_namespace}-terraform-st"
    key    = "${local.mt_environment}/vpc_data/terraform.tfstate"
    region = var.aws_region
  }
}

data "terraform_remote_state" "vpc_k8s" {
  backend = "s3"
  config = {
    bucket = "${local.mt_namespace}-terraform-st"
    key    = "${local.mt_environment}/vpc_k8s/terraform.tfstate"
    region = var.aws_region
  }
}
