resource "aws_iam_role" "rds_user_connect_role" {
  name = "${var.mt_environment}-${var.mt_stack}-${var.mt_service}-${var.db_user_name}"
  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Principal" : {
          "Service" : var.service_principal
        },
        "Action" : [
          "sts:AssumeRole",
          "sts:TagSession"
        ]
      }
    ]
  })
}

resource "aws_iam_policy" "rds_user_connect_policy" {
  name        = "rds-connect-${var.db_user_name}"
  description = "Policy to allow connecting to RDS with IAM authentication"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect   = "Allow",
        Action   = "rds-db:connect",
        Resource = "arn:aws:rds-db:${var.aws_region}:${data.aws_caller_identity.current.account_id}:dbuser:${aws_db_instance.rds.resource_id}/${var.db_user_name}"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "default_rds_connect_policy" {
  role       = aws_iam_role.rds_user_connect_role.name
  policy_arn = aws_iam_policy.rds_user_connect_policy.arn
}

data "aws_caller_identity" "current" {}

resource "aws_iam_role_policy_attachment" "role_rds_connect_policy" {
  for_each   = toset(var.authorized_role_names)
  role       = each.key
  policy_arn = aws_iam_policy.rds_user_connect_policy.arn
}
