# Specify the provider and access details
provider "aws" {
  region = "us-east-1"
  profile = "default"
  shared_credentials_file = "~/.aws/credentials"
  version = "~> 2.0"
}


terraform {
  required_version = ">=0.11"
}
