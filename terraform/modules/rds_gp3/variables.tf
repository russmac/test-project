variable "aws_region" {
  description = "The AWS region"
  type        = string
}

variable "mt_namespace" {
  description = "The AWS account"
  type        = string
}

variable "mt_stack" {
  description = "The AWS stack"
  type        = string
}

variable "mt_environment" {
  description = "The AWS environment"
  type        = string
}

variable "mt_service" {
  description = "The service name"
  type        = string
}

variable "vpc_data" {
  description = "The state output object from vpc_data workspace"
}

variable "vpc_k8s" {
  description = "The state output object from vpc_k8s workspace"
}

variable "root_password" {
  description = ""
  sensitive   = true
  validation {
    condition = alltrue([
      length(var.root_password) >= 24,
      length(var.root_password) <= 32,
      can(regex("[A-Za-z]", var.root_password)),  # Minimum one letter
      can(regex("\\d", var.root_password)),       # Minimum one number
      can(regex("[@$!%*#?&]", var.root_password)) # Minimum one special character
    ])
    error_message = "The Postgresql password must be between 24 and 32 characters long and must include at least one letter, one number, and one special character."
  }
}

variable "storage_size_gb" {
  description = "The GB of the db instance"
  type        = number
  validation {
    condition = alltrue([
      var.storage_size_gb < 4000,
      var.storage_size_gb >= 400 # Required for striping and custom IOPS
    ])
    error_message = "Effective use of gp3 storage type requires under 4000GB."
  }
}

variable "iops" {
  description = "The IOPS"
  type        = number
  validation {
    condition     = var.iops < 20000
    error_message = "IOPS requested is too high for effective use of gp3."
  }
}

variable "instance_type" {
  description = "The RDS instance type"
  type        = string
}

variable "db_user_name" {
  description = "The limited authorization user name to connect to the Postgresql database"
  type        = string
  validation {
    condition = alltrue([
      length(var.db_user_name) > 2,   # Minimum meaningful length
      length(var.db_user_name) <= 16, # Not too long!
      can(regex("^[a-zA-Z_\\$][a-zA-Z0-9_\\$]*$", var.db_user_name))
    ])
    error_message = "The Postgresql username must be between 1 and 32 characters long and can contain letters, numbers, underscores, and dollar signs. It should not start with a digit."
  }
}

variable "authorized_role_names" {
  description = "Requires roles already exists (as its an IAM principal), May create race conditions in DR"
  type        = list(string)
  validation {
    condition     = alltrue([for role in var.authorized_role_names : can(regex("[A-Za-z0-9-_]+$", role))])
    error_message = "Invalid IAM role name reference."
  }
}

variable "service_principal" {
  description = "The correct service principal of the service which will assume the role."
  type        = string
  default     = "pods.eks.amazonaws.com"
}

variable "skip_final_snapshot" {
  description = "Whether or not to skip the final snapshot"
  type        = bool
  default     = true
}

variable "deletion_protection" {
  description = "Deletion protection"
  type        = bool
  default     = false
}

locals {
  # https://docs.aws.amazon.com/whitepapers/latest/optimizing-postgresql-on-ec2-using-ebs/ebs-volume-types.html
  min_storage   = ceil(var.iops / 500)
  final_storage = max(var.storage_size_gb, local.min_storage)
}
