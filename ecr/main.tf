provider "aws" {
  region = "us-west-2" # Change to your desired region
}

resource "aws_ecr_repository" "my_repository" {
  name = "test-repo"
}

