#!/bin/bash

set -e
set -x

# ensure SSH agent has all keys
#ssh-add -A
ssh-add ~/.ssh/id_rsa
# set up the infrastructure
cd terraform
terraform init
terraform plan -lock=false -out=myplan
terraform apply -lock=false myplan""
#terraform apply -auto-approve
#terraform destroy -auto-approve

aws ec2 describe-instances --query "Reservations[*].Instances[*].PublicIpAddress" --output=text  > hosts

cp hosts.txt /ansible/hosts

cd ../ansible
# pull the instance information from Terraform, and run the Ansible playbook against it to configure
#TF_STATE=../terraform/terraform.tfstate ansible-playbook "--inventory-file=$(which terraform-inventory)" provision.yml

ansible-playbook provision.yml -i hosts

echo "Success!"

#cd ../terraform
#terraform output
