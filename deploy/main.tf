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
  ami           = var.ami_id
  instance_type = var.instance_type
  key_name      = var.ssh_key_name
  security_groups = [aws_security_group.instance_sg.name]
  user_data    = var.user_data
  tags         = merge(var.tags, { Name = "simple_java" })
}


