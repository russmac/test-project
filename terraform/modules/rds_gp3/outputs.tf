output "rds_instance" {
  value = aws_db_instance.rds
}

output "rds_user_connect_role" {
  value = aws_iam_role.rds_user_connect_role
}

output "rds_user_connect_policy" {
  value = aws_iam_policy.rds_user_connect_policy
}

output "rds_user_name" {
  value = var.user_name
}