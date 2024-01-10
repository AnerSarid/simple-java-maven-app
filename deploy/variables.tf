variable "aws_region" {
  description = "AWS region to deploy resources"
  default     = "eu-central-1"
}

variable "instance_type" {
  description = "The instance type of the EC2 instance"
  default     = "t2.micro"
}

variable "security_group_name" {
  description = "Name for the security group"
  default     = "instance-security-group"
}

variable "ingress_rules" {
  description = "Ingress rules for the security group"
  type = list(object({
    from_port = number
    to_port   = number
    protocol  = string
    cidrs     = list(string)
  }))
  default = [
    { from_port = 22, to_port = 22, protocol = "tcp", cidrs = ["0.0.0.0/0"] },
    { from_port = 443, to_port = 443, protocol = "tcp", cidrs = ["0.0.0.0/0"] }
  ]
}

variable "ami_id" {
  description = "AMI ID for the EC2 instance"
  type        = string
}

variable "ssh_key_name" {
  description = "SSH Key name for the EC2 instance"
  type        = string
  default     = null
}

variable "user_data" {
  description = "User data to initialize the EC2 instance"
  type        = string
  default     = ""
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}

