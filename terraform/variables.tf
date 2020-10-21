variable "public_key_path" {
  default = "~/.ssh/id_rsa.pub"
}

variable "key_name" {
  default = "terraform-ansible-example-key"
}

variable "ami_id" {
  type = string
  default = "ami-098f16afa9edf40be"
}
