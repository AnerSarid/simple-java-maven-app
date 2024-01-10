terraform {
  backend "s3" {
    bucket         = "aner-terra-bucket"
    key            = "statetf/terraform.tfstate"
    region         = "eu-central-1"
    dynamodb_table = "terraform-state-lock"
    encrypt        = true
  }
}

module "aws_ec2_instance" {
  source              = "./deploy"
  aws_region          = "eu-central-1"
  instance_type       = "t2.micro"
  security_group_name = "java-security"
  ami_id              = "ami-0a3411455bb49128a"
  ssh_key_name        = "ssh_key_1"
  user_data           = file("${path.module}/cloud-init.yaml")
  tags                = {}
  # ... other variables ...
}

output "ec2_instance_ip" {
  value = module.aws_ec2_instance.instance_ip_addr
}
