variable "aws_profile" {
  default = "mabletest"
}

variable "aws_region" {
  default = "ap-southeast-2"
}


locals {
  availability_zones = ["ap-southeast-2a"]
  mt_namespace       = reverse(split("/", abspath(path.root)))[3]
  mt_environment     = reverse(split("/", abspath(path.root)))[2]
  mt_stack           = reverse(split("/", abspath(path.root)))[1]
  mt_service         = reverse(split("/", abspath(path.root)))[0]
  vpc                = data.terraform_remote_state.vpc-k8s.outputs.vpc
  tags = {
    mt_namespace   = local.mt_namespace
    mt_environment = local.mt_environment
    terraform      = true
  }
}