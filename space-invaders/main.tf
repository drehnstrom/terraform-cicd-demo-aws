resource "aws_security_group" "allow-http" {
  count       = var.instance_count > 0 ? 1 : 0
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
  count         = var.instance_count
  ami           = var.image_id
  instance_type = var.instance_type
  vpc_security_group_ids = [aws_security_group.allow-http[0].id]

  user_data = file("install_space-invaders.sh")

  tags = {
    Name = "${var.project}-server-${count.index}"
  }
}
