provider "aws" {
  region = "us-east-1"
  access_key = "Don't use at home"
  secret_key = "Don't use at home"
}

variable "istest" {
  type = bool 
}

resource "aws_instance" "dev" {
  ami = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.micro"
  count = var.istest == true ? 1 : 0
}

resource "aws_instance" "prod" {
  ami = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.large"
  count = var.istest == false ? 1 : 0
}
