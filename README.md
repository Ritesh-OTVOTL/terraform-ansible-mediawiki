WORK Still in progress...

About The Project
This project is about to automate the media wiki server provisioning
in aws environment using terraform and ansible.
Created not to complex aws environment with one routable vpc and outbound internet
connectivity. Used t2.micro free tier rhel8 ami to host mediawiki.


Built With and In
This project is developed in Windows Subsystem for Linux(WSL) running ubuntu
on top of that. So some of package installation and requirement may differ.


Prerequisites :
python38
terraform required_version = ">=0.11"
ansible~=2.2
aws-cli/1.18.69 Python/3.8.5 Linux/4.4.0-18362-Microsoft botocore/1.16.19


Installation
pip3 install ansible
ansible --version


Terraform
wget https://releases.hashicorp.com/terraform/0.12.24/terraform_0.12.24_linux_amd64.zip
sudo apt-get install zip -y
unzip terraform*.zip
sudo mv terraform /usr/local/bin
terraform --version

Note : Please set the environment variable accordingly.

Usage
git clone https://github.com/Ritesh-OTVOTL/terraform-ansible-mediawiki.github
cd terraform-ansible-mediawiki/
./deploy.sh


Post-install configuration :Webserver (Apache)
Setting up Apache can be done in numerous ways according to your preferences. In this example I simply change Apache to look at /var/www by default, so the link to the wiki will be http://server/mediawiki. This is convenient for running more than one site on the server. If you only need mediawiki running on the server, change instances of /var/www below to /var/www/mediawiki (Also it works with: /var/www/mediawiki-1.35.0). Open /etc/httpd/conf/httpd.conf and search for and change these three lines:

DocumentRoot "/var/www"
<Directory "/var/www">     <-- this is the SECOND "<Directory" entry, not the 'root' one
DirectoryIndex index.html index.html.var index.php

Site can be access through - http://public_ip/mediawiki




License
Distributed under the Apache2.0.

Disclaimer
Nothing is perfect in this world. There are lots of things that need to be improve and corrected.


Contact
Name - Ritesh
Email - on.the.verge.of.the.life@gmail.com
