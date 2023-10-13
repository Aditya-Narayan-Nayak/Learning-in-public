provider "aws" {
    region = "us-east-1"
}

resource "aws_instance" "name" {
  ami = var.ami
  instance_type = "t2.micro"

  tags = {
    name = "myec2"
  }
  
}