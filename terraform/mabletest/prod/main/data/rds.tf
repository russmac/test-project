module "rds" {
  source         = "../../../../modules/rds_gp3"
  aws_region     = var.aws_region
  mt_environment = local.mt_environment
  mt_namespace   = local.mt_namespace
  mt_service     = local.mt_service
  mt_stack       = local.mt_stack
  vpc_data       = data.terraform_remote_state.vpc_data.outputs.vpc
  vpc_k8s        = data.terraform_remote_state.vpc_k8s.outputs.vpc

  # IAM configuration
  db_user_name             = "app"
  authorized_role_names = ["example-app"]

  # Prod configuration
  iops                = 13000
  storage_size_gb     = 400
  instance_type       = "db.m5.large"
  root_password       = random_password.rds.result
  deletion_protection = true
  skip_final_snapshot = false
}

resource "random_password" "rds" {
  length           = 24
  override_special = "#$%^&*()_+-="
}