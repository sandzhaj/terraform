provider "aws" {
  region = "ap-northeast-3"
  default_tags {
    tags = {
      Name    = "example10"
      Owner   = "Mark"
    }
  }
}

data "aws_ami" "latest_ubuntu" {
  owners      = ["099720109477"]
  most_recent = true
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }
}


resource "aws_instance" "my_webserver_with_latest_ubuntu_ami" {
  ami           = data.aws_ami.latest_ubuntu.id
  instance_type = "t3.micro"
}


output "latest_ubuntu_ami" {
  value = data.aws_ami.latest_ubuntu
}

output "latest_ubuntu_ami_id" {
  value = data.aws_ami.latest_ubuntu.id
}


output "latest_ubuntu_ami_name" {
  value = data.aws_ami.latest_ubuntu.name
}