data "aws_caller_identity" "current" {
}

data "terraform_remote_state" "vpc" {
  backend = "s3"

  config = {
    region = "us-east-1"
    bucket = format("%s-%s-terraform-state", var.namespace, var.stage)
    key = format("%s/vpc/terraform.tfstate", var.stage)
  }
}