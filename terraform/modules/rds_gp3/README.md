# rds_gp3

## Limitations
This module only supports gp3 storage

## Requirements
### Post-provisioning Postgresql user
After deployment of this module, RDS IAM authentication requires the user provisioned and the password configured in Postgresql using the below where foo_user is your user.

```sql
CREATE USER foo_user; 
GRANT rds_iam TO foo_user;
```

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |
| <a name="provider_time"></a> [time](#provider\_time) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_db_instance.rds](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_instance) | resource |
| [aws_db_parameter_group.custom_params](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_parameter_group) | resource |
| [aws_db_subnet_group.rds_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_subnet_group) | resource |
| [aws_iam_policy.rds_user_connect_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role.rds_user_connect_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.default_rds_connect_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.role_rds_connect_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_security_group.rds_sg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [time_static.timestamp](https://registry.terraform.io/providers/hashicorp/time/latest/docs/resources/static) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_subnet.db_subnets](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnet) | data source |
| [aws_subnet.k8s_subnets](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnet) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_authorized_role_names"></a> [authorized\_role\_names](#input\_authorized\_role\_names) | Requires roles already exists (as its an IAM principal), May create race conditions in DR | `list(string)` | n/a | yes |
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | The AWS region | `string` | n/a | yes |
| <a name="input_db_user_name"></a> [db\_user\_name](#input\_db\_user\_name) | The limited authorization user name to connect to the Postgresql database | `string` | n/a | yes |
| <a name="input_deletion_protection"></a> [deletion\_protection](#input\_deletion\_protection) | Deletion protection | `bool` | `false` | no |
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | The RDS instance type | `string` | n/a | yes |
| <a name="input_iops"></a> [iops](#input\_iops) | The IOPS | `number` | n/a | yes |
| <a name="input_mt_environment"></a> [mt\_environment](#input\_mt\_environment) | The AWS environment | `string` | n/a | yes |
| <a name="input_mt_namespace"></a> [mt\_namespace](#input\_mt\_namespace) | The AWS account | `string` | n/a | yes |
| <a name="input_mt_service"></a> [mt\_service](#input\_mt\_service) | The service name | `string` | n/a | yes |
| <a name="input_mt_stack"></a> [mt\_stack](#input\_mt\_stack) | The AWS stack | `string` | n/a | yes |
| <a name="input_root_password"></a> [root\_password](#input\_root\_password) | n/a | `any` | n/a | yes |
| <a name="input_service_principal"></a> [service\_principal](#input\_service\_principal) | The correct service principal of the service which will assume the role. | `string` | `"pods.eks.amazonaws.com"` | no |
| <a name="input_skip_final_snapshot"></a> [skip\_final\_snapshot](#input\_skip\_final\_snapshot) | Whether or not to skip the final snapshot | `bool` | `true` | no |
| <a name="input_storage_size_gb"></a> [storage\_size\_gb](#input\_storage\_size\_gb) | The GB of the db instance | `number` | n/a | yes |
| <a name="input_vpc_data"></a> [vpc\_data](#input\_vpc\_data) | The state output object from vpc\_data workspace | `any` | n/a | yes |
| <a name="input_vpc_k8s"></a> [vpc\_k8s](#input\_vpc\_k8s) | The state output object from vpc\_k8s workspace | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_authorized_role_names"></a> [authorized\_role\_names](#output\_authorized\_role\_names) | n/a |
| <a name="output_db_user_name"></a> [db\_user\_name](#output\_db\_user\_name) | n/a |
| <a name="output_rds_instance"></a> [rds\_instance](#output\_rds\_instance) | n/a |
| <a name="output_rds_user_connect_policy"></a> [rds\_user\_connect\_policy](#output\_rds\_user\_connect\_policy) | n/a |
| <a name="output_rds_user_connect_role"></a> [rds\_user\_connect\_role](#output\_rds\_user\_connect\_role) | n/a |
