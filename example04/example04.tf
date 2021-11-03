provider "aws" {
  region = "ap-northeast-3"
  default_tags {
    tags = {
      Name    = "example4"
      Owner   = "Mark"
    }
  }
}


resource "aws_instance" "my_webserver" {
  ami                    = "ami-0001d1dd884af8872"
  instance_type          = "t3.micro"
  vpc_security_group_ids = [aws_security_group.my_webserver.id]
  user_data = templatefile("user_data.sh.tpl", {
    owner = "Mark",
    string_list  = ["string1", "string2", "string3", "string4"]
  })

}


resource "aws_security_group" "my_webserver" {
  name        = "WebServerSG"
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
