// terraform count concept
provider "aws" {
  region = "us-east-1"
  access_key = "Don't use at home"
  secret_key = "Don't use at home"
}

variable "elb_name" {
  type = list
  default = ["dev", "test", "prod"]
}

resource "aws_iam_user" "lb" {
  name = "lb.${count.index}"
  count = 3
  path = "/system/"
}
 