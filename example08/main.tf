provider "aws" {
  region = "ap-northeast-3"
  default_tags {
    tags = {
      Name    = "example8"
      Owner   = "Mark"
    }
  }
}

resource "aws_instance" "my_server_web" {
  ami                    = "ami-03a71cec707bfc3d7"
  instance_type          = "t3.micro"
  vpc_security_group_ids = [aws_security_group.my_webserver.id]
  depends_on = [aws_instance.my_server_db, aws_instance.my_server_app]
  tags = {
    Role = "WEBSERVER"
  }
}

resource "aws_instance" "my_server_app" {
  ami                    = "ami-03a71cec707bfc3d7"
  instance_type          = "t3.micro"
  vpc_security_group_ids = [aws_security_group.my_webserver.id]
  depends_on = [aws_instance.my_server_db]
  tags = {
    Role = "APPLICATION"
  }
}


resource "aws_instance" "my_server_db" {
  ami                    = "ami-03a71cec707bfc3d7"
  instance_type          = "t3.micro"
  vpc_security_group_ids = [aws_security_group.my_webserver.id]

  tags = {
    Role = "DATABASE"
  }
}



resource "aws_security_group" "my_webserver" {
  name = "My Security Group"

  dynamic "ingress" {
    for_each = ["80", "443", "22"]
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
