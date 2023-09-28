# Pull Amazon Linux-2 image from AWS
data "aws_ami" "amazon_linux_2" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "owner-alias"
    values = ["amazon"]
  }

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm*"]
  }
}

# Create security group
resource "aws_security_group" "ec2_access" {
  name        = "ec2-access"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Allow SSH access from anywhere (not recommended for production)
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Allow HTTP access from anywhere (not recommended for production)
  }
}

resource "aws_instance" "instance" {
  # We are using AWS linux 2 instance
  ami                    = data.aws_ami.amazon_linux_2.id
  instance_type          = var.instance_type
  subnet_id              = "subnet-01eddad3eb4ecfebc"
  key_name               = "admin-key"
  vpc_security_group_ids = [aws_security_group.ec2_access.id]

  lifecycle {
    create_before_destroy = false
  }

  root_block_device {
    delete_on_termination = true
  }

  tags = {
    Name        = var.instance_name
  }

}
