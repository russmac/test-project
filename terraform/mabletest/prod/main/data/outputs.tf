output "rds_rds_instance_id" {
  value = module.rds.rds_instance.id
}

output "rds_rds_user_name" {
  value = module.rds.db_user_name
}

output "rds_rds_user_connect_policy" {
  value = module.rds.rds_user_connect_policy
}

output "rds_rds_user_connect_role" {
  value = module.rds.rds_user_connect_role
}

# The role names authorized to access the RDS instance provided to the module as `authorized_role_names`
output "rds_authorized_role_names" {
  value = module.rds.authorized_role_names
}