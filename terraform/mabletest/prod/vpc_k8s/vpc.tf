module "vpc" {
  source                  = "terraform-aws-modules/vpc/aws"
  version                 = "v5.9.0"
  name                    = "${local.mt_environment}-k8s"
  azs                     = local.availability_zones
  cidr                    = local.vpc_cidr
  map_public_ip_on_launch = false
  enable_dns_hostnames    = false
  enable_dns_support      = false
  single_nat_gateway      = true
  enable_nat_gateway      = false

  private_subnets = [
    cidrsubnet(local.vpc_cidr, 5, 0),
    cidrsubnet(local.vpc_cidr, 5, 1),
  ]

}