provider "aws" {
  region = "us-east-1"
  access_key = "AKIASR6IOZCLMGBU54VS"
  secret_key = "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"
}

resource "aws_iam_user" "lb" {
  name = var.usernumber
  path = "/system/"
}
