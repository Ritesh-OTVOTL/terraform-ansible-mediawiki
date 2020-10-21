#!/bin/bash

set -e
set -x

#ssh-add -A
ssh-add ~/.ssh/id_rsa


cd terraform
terraform init
terraform plan -lock=false -out=myplan
#terraform apply -lock=false myplan""
terraform destroy -auto-approve

cd ../ansible

aws ec2 describe-instances --query "Reservations[*].Instances[*].PublicIpAddress" --output=text  > hosts

ansible-playbook provision.yml -i hosts

echo "Success!"

#cd ../terraform
#terraform output
