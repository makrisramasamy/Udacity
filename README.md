# Udacity


Udacity is a Terraformlibrary for providing number of vm's.

## Installation

Use main.tf and variable.tf  to provide multiple virtual machine.
user packer.json to create new image on your subscription
use tagging policy to have tags mandatory for any resource creation


## Usage

terraform init
terraform plan
terraform apply
terraform destory


set Environemental variables  before running packer 
$ export TF_VAR_subscription_id=xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxx
$ export TF_VAR_client_id=xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxx
$ export TF_VAR_client_secret=xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxx
$ export TF_VAR_tenant_id=xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxx

packer build .\server.json

use tagging policy for creating new policy definition

## Contributing
Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

Please make sure to update tests as appropriate.
