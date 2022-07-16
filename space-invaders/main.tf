resource "aws_security_group" "allow-http" {
  name        = "${var.project}-sec-group-allow-http"
  description = "Enable HTTP Access"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "HTTP Access"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "vm" {
  count         = 1
  ami           = var.image_id
  instance_type = var.instance_type
  vpc_security_group_ids = [aws_security_group.allow-http.id]

  user_data = file("install_space-invaders.sh")

  tags = {
    Name = "${var.project}-server-${count.index}"
  }
}
