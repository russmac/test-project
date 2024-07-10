output "rds_instance" {
  value = aws_db_instance.rds
}

output "rds_user_connect_role" {
  value = aws_iam_role.rds_user_connect_role
}

output "rds_user_connect_policy" {
  value = aws_iam_policy.rds_user_connect_policy
}

output "db_user_name" {
  value = var.db_user_name
}

output "authorized_role_names" {
  value = aws_iam_role_policy_attachment.role_rds_connect_policy[*]
}