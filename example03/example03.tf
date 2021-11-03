provider "aws" {
  region = "ap-northeast-3"
  default_tags {
    tags = {
      Name    = "example3"
      Owner   = "Mark"
    }
  }
}


resource "aws_instance" "server1" {
  ami                    = ""
  instance_type          = "t3.micro"
  vpc_security_group_ids = [aws_security_group.sg1.id]
  user_data              = file("user_data.sh")

}


resource "aws_security_group" "sg1" {
  name        = "WebServer Security Group"
  description = "My First SecurityGroup"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}
