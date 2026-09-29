provider "aws" {
  region = "us-east-1"
}

resource "aws_security_group" "devops_sg" {
  name        = "devops-lab-sg"
  description = "SSH and HTTP"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "devops_server" {
  ami                    = "ami-0b245cc5f82576748"
  instance_type          = "t3.micro"
  key_name               = "devops-lab-key"
  vpc_security_group_ids = [aws_security_group.devops_sg.id]

  tags = {
    Name = "DevOps-Lab-Server"
  }
}

output "public_ip" {
  value = aws_instance.devops_server.public_ip
}
