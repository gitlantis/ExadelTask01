terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }

  required_version = ">= 0.14.9"
}

provider "aws" {
  profile    = "default"
  region     = "eu-central-1"
  access_key = "AKIATVMKYGXW6TSEPJWN"
  secret_key = "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"
}

#Instance Ubuntu
resource "aws_instance" "app_server" {
  ami           = "ami-05e1e66d082e56118"
  instance_type = "t2.micro"
  key_name      = "ASPair01"
  provisioner "remote-exec" {
    inline = [
      "sudo apt update",
      "sudo apt install nginx -y",
      "sudo chown -R ubuntu:ubuntu /var/www",
      "echo Hello World > /var/www/html/index.html",
      "lsb_release -a >> /var/www/html/index.html",
      "sudo apt install docker.io -y",
    ]

    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file("./ASPair01.pem")
      host = aws_instance.app_server.public_ip
    }    
  }
  tags = {
    Name = "Ubuntu"
  }

  vpc_security_group_ids = ["${aws_security_group.allow_ubuntu.id}"]

}

#instance CentOS
resource "aws_instance" "test_server" {
  ami           = "ami-073a8e22592a4a925"
  instance_type = "t2.micro"
  key_name      = "ASPair01"

  tags = {
    Name = "CentOS"
  }

  vpc_security_group_ids = ["${aws_security_group.allow_centos.id}"]

}

# Security group for Ubuntu
resource "aws_security_group" "allow_ubuntu" {
  name        = "allow_ubuntu"
  description = "Ubuntu security group"

  tags = {
    Name = "allow_ubuntu"
  }
}

# Security group for CentOS
resource "aws_security_group" "allow_centos" {
  name        = "allow_centos"
  description = "CentOS security group"

  tags = {
    Name = "allow_centos"
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
  security_group_id = aws_security_group.allow_ubuntu.id
}

# Security Group rule 2: Allow SSH (TCP 22) incoming traffic from anywhere
resource "aws_security_group_rule" "ubuntu_in_ssh" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.allow_ubuntu.id
}

# Security Group rule 3: Allow HTTP (TCP 80) incoming traffic from anywhere
resource "aws_security_group_rule" "ubuntu_in_http" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.allow_ubuntu.id
}

# Security Group rule 4: Allow HTTPS (TCP 443) incoming traffic from anywhere
resource "aws_security_group_rule" "ubuntu_in_https" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.allow_ubuntu.id
}

# Security Group rule 5: Allow ICMP packages incoming traffic from anywhere
resource "aws_security_group_rule" "ubuntu_in_icmp" {
  type              = "ingress"
  from_port         = -1
  to_port           = -1
  protocol          = "icmp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.allow_ubuntu.id
}

# Security Group rule 1: Allow SSH (TCP 22) incoming traffic from anywhere
resource "aws_security_group_rule" "centos_in_ssh" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["172.31.0.0/16"]
  security_group_id = aws_security_group.allow_centos.id
}

#Security Group rule 2: Allow HTTP (TCP 80) incoming traffic from anywhere
resource "aws_security_group_rule" "centos_in_http" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["172.31.0.0/16"]
  security_group_id = aws_security_group.allow_centos.id
}

# Security Group rule 3: Allow HTTPS (TCP 443) incoming traffic from anywhere
resource "aws_security_group_rule" "centos_in_https" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["172.31.0.0/16"]
  security_group_id = aws_security_group.allow_centos.id
}

# Security Group rule 4: Allow ICMP packages incoming traffic from anywhere
resource "aws_security_group_rule" "centos_in_icmp" {
  type              = "ingress"
  from_port         = -1
  to_port           = -1
  protocol          = "icmp"
  cidr_blocks       = ["172.31.0.0/16"]
  security_group_id = aws_security_group.allow_centos.id
}

# Security Group rule 1: Allow SSH (TCP 22) outgoing traffic from anywhere
resource "aws_security_group_rule" "centos_out_ssh" {
  type              = "egress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["172.31.0.0/16"]
  security_group_id = aws_security_group.allow_centos.id
}

# Security Group rule 2: Allow HTTP (TCP 80) outgoing traffic from anywhere
resource "aws_security_group_rule" "centos_out_http" {
  type              = "egress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["172.31.0.0/16"]
  security_group_id = aws_security_group.allow_centos.id
}

# Security Group rule 3: Allow HTTPS (TCP 443) outgoing traffic from anywhere
resource "aws_security_group_rule" "centos_out_https" {
  type              = "egress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["172.31.0.0/16"]
  security_group_id = aws_security_group.allow_centos.id
}

# Security Group rule 4: Allow ICMP packages outgoing traffic from anywhere
resource "aws_security_group_rule" "centos_out_icmp" {
  type              = "egress"
  from_port         = -1
  to_port           = -1
  protocol          = "icmp"
  cidr_blocks       = ["172.31.0.0/16"]
  security_group_id = aws_security_group.allow_centos.id
}

#"${aws_eip.app_server.public_ip}/32"
