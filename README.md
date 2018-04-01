# Infrastructure with Terraform

> Provisioning AWS infrastructure with Terraform

## Setup

1. Create AWS user and group with `AdministratorAccess[policy]`. Terraform will
   use this user to all operations.
2. Create `terraform.tfvars` file inside of *environment* directory (e.g. **staging**,
   **production** etc) with following mandatory variables:

    ```
    access_key = "<access-key-for-terraform-user>"
    secret_key = "<secret-key-for-terraform-user>"
    region = "<your-aws-region>"
    availability_zone = "<availability-zone>"
    
    application_name = "<application_name>"
    application_environment = "<application_environment>"
    application_description = "<application_description>"
    ```
