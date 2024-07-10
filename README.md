# Mable example-app project

## Description
This repository contains Terraform to deploy an IAM enabled Postgresql RDS instance 

## What does it do

- Deploys a Terraform stack containing an RDS instance with IAM authentication enabled
- Deploys an IAM authorized role to be utilised by EKS pods
- Optionally configures IAM authorization for a list of provided roles

## Implementation details
The RDS module has been specifically configured around cost optimisation for a known quantity of IOPS
The validations have been configured to comply with suitable gp3 configuration.

## Filesystem hierarchy
Under this hierarchy the naming standard is represented and directly sourced from the folder naming
All vars and locals prefixed with mt_ indicate organisational business logic.

`run_order.env` indicates the correct run order to mitigate race conditions and for DR. (reversed for destruction)

```shell
.
├── mabletest
│   ├── backend
│   └── prod
│       ├── main
│       │   ├── data
│       │   └── example-app
│       ├── vpc_data
│       └── vpc_k8s
└── modules
    └── rds_gp3
```

- `/mabletest/` This is the account alias / `mt_namespace` this is not the k8s namespace, may make more sense to be `mt_account` here
- `/main/` This is the default stack name `mt_stack`, Alternate names can be used for canaries, A-B deployments or ephemeral deployments
- `/prod/` The environment `mt_environment`
- `/data` The service `mt_service` (sometimes the folder name doesn't make sense and its hardcoded to a better name)

## Known limitations
- A full end to end test confirming working DB credentials has not been completed due to time considerations. Small adjustments may be required.

- The k8s vpc has been deployed as a mock without required VPC peering.

## Further context on design
An RDS VPC endpoint was not created as the scope indicated the two VPC should be considered part of the same network (assuming peered)