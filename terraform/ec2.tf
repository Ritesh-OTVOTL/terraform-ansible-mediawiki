locals {
  vm_user = "ec2-user"
}

data "aws_ami" "rhel8" {
  most_recent = true

  owners = ["309956199498"] // Red Hat's account ID.

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "name"
    values = ["RHEL-8*"]
  }
}

resource "aws_key_pair" "auth" {
  key_name   = "${var.key_name}"
  public_key = "${file(var.public_key_path)}"
}

resource "aws_instance" "web" {
  instance_type = "t2.micro"
  tags = {
    Name = "media wiki on rhel"
    Description = "for TW"
  }


  #ami = "${data.aws_ami.ubuntu.id}" // Commented because want to use only free tier.

  ami = "ami-098f16afa9edf40be"


  key_name = "${var.key_name}"


  vpc_security_group_ids = ["${aws_security_group.sg.id}"]

  subnet_id = "${aws_subnet.pubsubnet.id}"

  provisioner "local-exec" {
    command = "echo ${aws_instance.web.public_ip} > hosts.txt"
  }

  provisioner "remote-exec" {
    inline = ["echo Successfully connected"]
    connection {
      host = "${aws_instance.web.public_ip}"
      user = "${local.vm_user}"
    }
  }
}
