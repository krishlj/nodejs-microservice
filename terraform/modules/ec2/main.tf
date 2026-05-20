variable "subnet_id" {}
variable "vpc_id" {}

resource "aws_security_group" "ec2_sg" {
  name   = "nodejs-sg"
  vpc_id = var.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 3000
    to_port     = 3000
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

resource "aws_key_pair" "deployer" {
  key_name   = "nodejs-key"
  public_key = file("C:/Users/krish/.ssh/id_ed25519.pub")
}

resource "aws_instance" "app_server" {
  ami                    = "ami-03f4878755434977f"
  instance_type          = "t2.micro"
  subnet_id              = var.subnet_id
  vpc_security_group_ids = [aws_security_group.ec2_sg.id]
  key_name               = aws_key_pair.deployer.key_name

  tags = {
    Name = "Nodejs-Microservice"
  }
}

output "public_ip" {
  value = aws_instance.app_server.public_ip
}