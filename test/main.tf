provider "aws" {
  region = "us-west-2"
}

terraform {
  required_version = ">= 1.0"
  backend "s3" {
    bucket = "tflessons-state"
    key    = "test/terraform.state"
    region = "us-west-2"
  }
}

# Use data from main
data "terraform_remote_state" "main" {
  backend = "s3"
  config = {
    bucket = "tflessons-state"
    key    = "main/terraform.state"
    region = "us-west-2"
  }
}
