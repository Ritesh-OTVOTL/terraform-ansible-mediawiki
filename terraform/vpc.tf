# Create a VPC to launch our instances into
resource "aws_vpc" "vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    name = "Routable VPC"
    description = "for TW"
  }
}

# Create an internet gateway to give our subnet access to the outside world
resource "aws_internet_gateway" "ig" {
  vpc_id = "${aws_vpc.vpc.id}"
  tags = {
    name = "Internet Gateway"
    description = "for TW"
  }
}

# Grant the VPC internet access on its main route table
resource "aws_route" "route" {
  route_table_id         = "${aws_vpc.vpc.main_route_table_id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${aws_internet_gateway.ig.id}"
}

# Create a subnet to launch our instances into
resource "aws_subnet" "pubsubnet" {
  vpc_id                  = "${aws_vpc.vpc.id}"
  cidr_block              = "10.0.0.0/24"
  map_public_ip_on_launch = true
  tags = {
    name = "Public Subnet"
    description = "for TW"
  }
}

# Our default security group to access
# the instances over SSH and HTTP
resource "aws_security_group" "sg" {
  name        = "Security Group"
  description = "for TW"
  vpc_id      = "${aws_vpc.vpc.id}"


  # SSH access from anywhere
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # HTTP access from anywhere
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # outbound internet access
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
