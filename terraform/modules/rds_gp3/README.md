# rds_gp3

## Further steps
Postgresql requires the user provisioned and the password configured using the below where foo_user is your user.

```sql
CREATE USER foo_user; 
GRANT rds_iam TO foo_user;
```

## Limitations
This module only supports gp3 storage