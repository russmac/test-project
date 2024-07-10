variable "aws_profile" {
  type    = string
  default = "mabletest"
}

variable "aws_region" {
  type    = string
  default = "ap-southeast-2"
}

locals {
  vpc_cidr           = "10.2.0.0/16"
  availability_zones = ["ap-southeast-2a", "ap-southeast-2b"]
  mt_namespace       = reverse(split("/", abspath(path.root)))[2]
  mt_environment     = reverse(split("/", abspath(path.root)))[1]
  tags = {
    mt_namespace   = "mabletest"
    mt_environment = local.mt_environment
    terraform      = true
  }
}
