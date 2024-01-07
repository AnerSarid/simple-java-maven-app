provider "aws" {
  region = var.aws_region
}

resource "aws_security_group" "instance_sg" {
  name        = var.security_group_name
  description = "Security group for EC2 instance allowing Docker Context and HTTP/HTTPS"
  
  dynamic "ingress" {
    for_each = var.ingress_rules
    content {
      from_port   = ingress.value.from_port
      to_port     = ingress.value.to_port
      protocol    = ingress.value.protocol
      cidr_blocks = ingress.value.cidrs
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "example" {
  ami           = "ami-0a3411455bb49128a"
  instance_type = var.instance_type
  key_name		= "ssh_key_1"
  security_groups = [aws_security_group.instance_sg.name]
  user_data = file("cloud-init.yaml")
  tags = {
    Name = "simple_java"
  }
}


