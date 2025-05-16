provider "aws" {
  region = "eu-west-3" 
} 
data "aws_ami" "ubuntu_ami" {
  most_recent = true
  owners = [ "099720109477" ]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
    }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
    }
}
module "securitygroup" {
  source  = "../modules/securitygroup"
  security_group_name = "web_amine_sg"
}

module "ec2" {
  source = "../modules/ec2"
  ami = data.aws_ami.ubuntu_ami.id
  instance_type = "t2.micro"
  key_name = "mini-projet-gitlab"
  availability_zone = "eu-west-3a"
  user = "ubuntu"
  security_group_name = module.securitygroup.name
  tag_name = "web_amine_ec2"
}

module "eip" {
  source           = "../modules/eip"
  eip_name         = "eip-amine_web"
}

module "ebs" {
  source       = "../modules/ebs"
  ebs_zone = "eu-west-3a"
  ebs_size = 10
  
}

resource "aws_eip_association" "eip_association" {
    instance_id = module.ec2.ec2_id
    allocation_id = module.eip.eip_id
}

resource "aws_volume_attachment" "ebs_att" {
    device_name = "/dev/sdh"
    instance_id = module.ec2.ec2_id
    volume_id = module.ebs.ebs_id
}
