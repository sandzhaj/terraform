provider "aws" {
  region = "ap-northeast-3"
  default_tags {
    tags = {
      Name    = "example7"
      Owner   = "Mark"
    }
  }
}

resource "aws_eip" "my_static_ip" {
  instance = aws_instance.my_webserver.id
}


resource "aws_instance" "my_webserver" {
  ami                    = "ami-0001d1dd884af8872"
  instance_type          = "t3.micro"
  vpc_security_group_ids = [aws_security_group.my_webserver.id]
  user_data = templatefile("user_data.sh.tpl", {
    owner = "Mark",
    string_list  = ["string1", "string2", "string3", "string3"]
  })


  lifecycle {
    create_before_destroy = true
  }

}


resource "aws_security_group" "my_webserver" {
  name        = "WebServer Security Group"
  description = "My First SecurityGroup"


  dynamic "ingress" {
    for_each = ["80", "443"]
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }


  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}



