resource "aws_db_instance" "rds" {
  storage_type                        = "gp3"
  iops                                = var.iops
  allocated_storage                   = local.final_storage
  max_allocated_storage               = local.final_storage
  instance_class                      = var.instance_type
  identifier                          = "${var.mt_environment}-${var.mt_stack}-${var.mt_service}"
  engine                              = "postgres"
  engine_version                      = "16.3"
  username                            = "root"
  password                            = var.root_password
  parameter_group_name                = aws_db_parameter_group.custom_params.name
  db_subnet_group_name                = aws_db_subnet_group.rds_group.name
  vpc_security_group_ids              = [aws_security_group.rds_sg.id]
  multi_az                            = true
  auto_minor_version_upgrade          = true
  backup_retention_period             = 7
  deletion_protection                 = var.deletion_protection
  iam_database_authentication_enabled = true
  storage_encrypted                   = true
  final_snapshot_identifier           = "pre-destroy-final-snapshot-${time_static.timestamp.unix}"
  skip_final_snapshot                 = var.skip_final_snapshot

  tags = {
    Name = "${var.mt_environment}-${var.mt_stack}-${var.mt_service}"
  }
}

resource "time_static" "timestamp" {}

# https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/Appendix.PostgreSQL.CommonDBATasks.Parameters.html
resource "aws_db_parameter_group" "custom_params" {
  name   = "${var.mt_environment}-${var.mt_stack}-${var.mt_service}"
  family = "postgres16"

  parameter {
    name  = "statement_timeout"
    value = "3600000"
  }

  parameter {
    name  = "rds.log_retention_period"
    value = "1440"
  }

  parameter {
    name  = "track_activities"
    value = 1
  }

  parameter {
    name  = "quote_all_identifiers"
    value = 0
  }

  tags = {
    Name = "${var.mt_environment}-${var.mt_stack}-${var.mt_service}"
  }

}

