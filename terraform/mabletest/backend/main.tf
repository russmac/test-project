module "terraform_state_backend" {
  source        = "cloudposse/tfstate-backend/aws"
  version       = "0.38.1"
  namespace     = local.mt_namespace
  name          = "terraform"
  attributes    = ["st"]
  force_destroy = true
  tags          = local.tags
}