variable "aws_profile" {
  type    = string
  default = "mabletest"
}

variable "aws_region" {
  type    = string
  default = "ap-southeast-2"
}

locals {
  mt_namespace = reverse(split("/", abspath(path.root)))[1]
  tags = {
    mt_terraform = true,
    mt_namespace = local.mt_namespace
  }
}
