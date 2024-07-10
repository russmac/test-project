resource "aws_db_subnet_group" "rds_group" {
  name       = "${var.mt_environment}-${var.mt_stack}-${var.mt_service}"
  subnet_ids = var.vpc_data.database_subnets

  tags = {
    Name = "${var.mt_environment}-${var.mt_stack}-${var.mt_service}"
  }
}

data "aws_subnet" "db_subnets" {
  for_each = toset(var.vpc_data.database_subnets)
  id       = each.key
}

data "aws_subnet" "k8s_subnets" {
  for_each = toset(var.vpc_k8s.private_subnets)
  id       = each.key
}

resource "aws_security_group" "rds_sg" {
  vpc_id = var.vpc_data.vpc_id
  name   = "${var.mt_environment}-${var.mt_stack}-${var.mt_service}"

  dynamic "ingress" {
    for_each = data.aws_subnet.db_subnets
    content {
      from_port   = 5432
      to_port     = 5432
      protocol    = "tcp"
      cidr_blocks = [ingress.value.cidr_block]
    }
  }

  dynamic "ingress" {
    for_each = data.aws_subnet.k8s_subnets
    content {
      from_port   = 5432
      to_port     = 5432
      protocol    = "tcp"
      cidr_blocks = [ingress.value.cidr_block]
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.mt_environment}-${var.mt_stack}-${var.mt_service}"
  }
}
