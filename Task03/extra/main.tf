terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }

  required_version = ">= 0.14.9"
}

data "aws_ami" "latest-ubuntu" {
  owners      = ["self", "aws-marketplace"]
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

data "aws_ami" "latest-centos" {
  owners      = ["self", "aws-marketplace"]
  most_recent = true

  filter {
    name   = "name"
    values = ["CentOS Linux 7 x86_64 HVM EBS *"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }
}


provider "aws" {
  profile    = "default"
  region     = "eu-central-1"
  access_key = "-"
  secret_key = "-"
}

#Instance Ubuntu
resource "aws_instance" "extra_app_server" {
  ami           = data.aws_ami.latest-ubuntu.id
  instance_type = "t2.micro"
  key_name      = "ASPair01"

  tags = {
    Name = "Ubuntu"
  }

  vpc_security_group_ids = ["${aws_security_group.extra_allow_ubuntu.id}"]

}

#instance CentOS
resource "aws_instance" "extra_test_server" {
  ami           = data.aws_ami.latest-centos.id
  instance_type = "t2.micro"
  key_name      = "ASPair01"  
 
  tags = {
    Name = "CentOS"
  }

  vpc_security_group_ids = ["${aws_security_group.extra_allow_centos.id}"]

}

# Security group for Ubuntu
resource "aws_security_group" "extra_allow_ubuntu" {
  name        = "extra_allow_ubuntu"
  description = "Ubuntu security group"

  tags = {
    Name = "extra_allow_ubuntu"
  }
}

# Security group for CentOS
resource "aws_security_group" "extra_allow_centos" {
  name        = "extra_allow_centos"
  description = "CentOS security group"

  tags = {
    Name = "extra_allow_centos"
  }
}

# Security Group rule 1: Allow all outgoing traffic for any protocol
resource "aws_security_group_rule" "ubuntu_out_all" {
  type              = "egress"
  from_port         = 0
  to_port           = 65535
  protocol          = "all"
  cidr_blocks       = ["0.0.0.0/0"]
  ipv6_cidr_blocks  = ["::/0"]
  security_group_id = aws_security_group.extra_allow_ubuntu.id
}

# Security Group rule 2: Allow SSH (TCP 22) incoming traffic from anywhere
resource "aws_security_group_rule" "ubuntu_in_ssh" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.extra_allow_ubuntu.id
}

# Security Group rule 3: Allow HTTP (TCP 80) incoming traffic from anywhere
resource "aws_security_group_rule" "ubuntu_in_http" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.extra_allow_ubuntu.id
}

# Security Group rule 4: Allow HTTPS (TCP 443) incoming traffic from anywhere
resource "aws_security_group_rule" "ubuntu_in_https" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.extra_allow_ubuntu.id
}

# Security Group rule 5: Allow ICMP packages incoming traffic from anywhere
resource "aws_security_group_rule" "ubuntu_in_icmp" {
  type              = "ingress"
  from_port         = -1
  to_port           = -1
  protocol          = "icmp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.extra_allow_ubuntu.id
}

# Security Group rule 1: Allow SSH (TCP 22) incoming traffic from anywhere
resource "aws_security_group_rule" "centos_in_ssh" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["172.31.0.0/16"]
  security_group_id = aws_security_group.extra_allow_centos.id
}

#Security Group rule 2: Allow HTTP (TCP 80) incoming traffic from anywhere
resource "aws_security_group_rule" "centos_in_http" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["172.31.0.0/16"]
  security_group_id = aws_security_group.extra_allow_centos.id
}

# Security Group rule 3: Allow HTTPS (TCP 443) incoming traffic from anywhere
resource "aws_security_group_rule" "centos_in_https" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["172.31.0.0/16"]
  security_group_id = aws_security_group.extra_allow_centos.id
}

# Security Group rule 4: Allow ICMP packages incoming traffic from anywhere
resource "aws_security_group_rule" "centos_in_icmp" {
  type              = "ingress"
  from_port         = -1
  to_port           = -1
  protocol          = "icmp"
  cidr_blocks       = ["172.31.0.0/16"]
  security_group_id = aws_security_group.extra_allow_centos.id
}

# Security Group rule 1: Allow SSH (TCP 22) outgoing traffic from anywhere
resource "aws_security_group_rule" "centos_out_ssh" {
  type              = "egress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["172.31.0.0/16"]
  security_group_id = aws_security_group.extra_allow_centos.id
}

# Security Group rule 2: Allow HTTP (TCP 80) outgoing traffic from anywhere
resource "aws_security_group_rule" "centos_out_http" {
  type              = "egress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["172.31.0.0/16"]
  security_group_id = aws_security_group.extra_allow_centos.id
}

# Security Group rule 3: Allow HTTPS (TCP 443) outgoing traffic from anywhere
resource "aws_security_group_rule" "centos_out_https" {
  type              = "egress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["172.31.0.0/16"]
  security_group_id = aws_security_group.extra_allow_centos.id
}

# Security Group rule 4: Allow ICMP packages outgoing traffic from anywhere
resource "aws_security_group_rule" "centos_out_icmp" {
  type              = "egress"
  from_port         = -1
  to_port           = -1
  protocol          = "icmp"
  cidr_blocks       = ["172.31.0.0/16"]
  security_group_id = aws_security_group.extra_allow_centos.id
}
