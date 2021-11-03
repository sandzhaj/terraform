provider "aws" {
  region = "ap-northeast-3"
  default_tags {
    tags = {
      Example = "example2"
      Owner   = "Mark"
    }
  }
}


resource "aws_instance" "server1" {
  ami                    = "ami-0001d1dd884af8872"
  instance_type          = "t3.micro"
  vpc_security_group_ids = [aws_security_group.sg1.id]
  user_data              = <<EOF
#!/bin/bash
apt update
apt install apache2 -y
service apache2 start
EOF

  tags = {
    Name = "Web Server"
  }
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
