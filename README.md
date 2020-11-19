# Udacity


Udacity is a Terraform script for provisioning vm based on user input.

## Installation

Use main.tf and variable.tf  to provide multiple virtual machine.
user packer.json to create new image on your subscription
use tagging policy to have tags mandatory for any resource creation


## Usage

Terraform Build

User need to provide Resource name , resource Group name and No.of vms to create 

terraform init
terraform plan
terraform apply
terraform destory

Packer build

set Environemental variables  before running packer 
$ export TF_VAR_subscription_id=xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxx
$ export TF_VAR_client_id=xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxx
$ export TF_VAR_client_secret=xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxx
$ export TF_VAR_tenant_id=xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxx

packer build .\server.json

Azure Policy 

Azure policy to enforce  tagging rules - To avoid scenario of resources being deployed to subscription in absence of tags.

## Contributing
Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

Please make sure to update tests as appropriate.
