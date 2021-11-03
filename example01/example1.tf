provider "aws" {
  region = "ap-northeast-3"
}


resource "aws_instance" "server" {
  ami           = "ami-0001d1dd884af8872"
  instance_type = "t3.micro"

  tags = {
    Name  = "Server 1"
    Owner = "Mark"
  }
}

resource "aws_instance" "server2" {
  ami           = "ami-0001d1dd884af8872"
  instance_type = "t3.small"

  tags = {
    Name  = "Server 2"
    Owner = "Mark"
  }
}

resource "aws_instance" "server3" {
  ami           = "ami-0001d1dd884af8872"
  instance_type = "t3.small"
  tags = {
    Name  = "Server 3"
    Owner = "Mark"
  }

}
