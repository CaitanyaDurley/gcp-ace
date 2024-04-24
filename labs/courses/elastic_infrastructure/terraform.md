# Automated deployment of infrastructure using Terraform
Terraform is preinstalled on Cloud Shell
## Init terraform with Google
```sh
# Check terraform is installed
terraform --version
# Home dir for terraform configuration
mkdir tfinfra && cd tfinfra
```
Terraform uses a plugin based architecture to support the numerous infrastructure providers available.
Each _provider_ is its own encapsulated binary distributed by terraform itself.
Put the following into provider.tf
```
provider "google" {}
```
and run `terraform init` to initialise terraform with the plugins necessary to talk to Google APIs.

## Create infrastructure
We create:
1. An auto mode network `mynetwork`
1. A firewall rule
1. Two VM instances

Configuration for the auto network and the firewall rule is in `mynetwork.tf`

### Module
We define the VM instances by creating a module (reusable configuration) which both instances can then leverage.
The module configuration lives in `instance/main.tf` with variables defined in `instance/variables.tf`.
The configuration for our two instances lives in `myinstances.tf`.

### Deploy
```sh
# Format the configuration files in a canonical style
terraform fmt
terraform init
# Create an execution plan (dry run)
terraform plan
# Apply the desired changes
terraform apply
```
