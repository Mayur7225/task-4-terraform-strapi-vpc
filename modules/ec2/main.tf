resource "aws_security_group" "private_sg" {
  vpc_id = var.vpc_id

  ingress {
    from_port   = 1337
    to_port     = 1337
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "this" {
  ami           = "ami-03f4878755434977f" # Ubuntu
  instance_type = var.instance_type
  subnet_id     = var.private_subnet_id
  security_groups = [aws_security_group.private_sg.id]
  user_data     = file("${path.root}/user_data.sh")
}

output "instance_id" {
  value = aws_instance.this.id
}

