# prod/main/data
## Security considerations
This is a highly authorized workspace, the root master password is weakly hashed in local state and memory.
It is also exposed to anyone with s3 bucket authorization to the specific path in the s3 state bucket for this workspace.