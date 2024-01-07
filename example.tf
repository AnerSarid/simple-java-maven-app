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
  source                = "/home/anersarid/git/devops/simple-java-maven-app/deploy/"
  aws_region            = "eu-central-1"
  instance_type         = "t2.micro"
  security_group_name   = "java-security"
  ansible_playbook_path = "/home/anersarid/git/devops/elk/deploy_app.yaml"
  ssh_key_path          = "/home/anersarid/Downloads/ssh_key_1.pem"
  # ... other variables ...
}


output "ec2_instance_ip" {
  value = module.aws_ec2_instance.instance_ip_addr
}
