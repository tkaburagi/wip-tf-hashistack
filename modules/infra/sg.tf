# Vault
resource "aws_security_group" "vault_security_group" {
  name = "vault_security_group"
  description = "Vault Sercuriy Group"
  vpc_id = "${aws_vpc.playground.id}"

  ingress {
    protocol    = "tcp"
    from_port   = 22
    to_port     = 22
    cidr_blocks     = ["0.0.0.0/0"]
  }

  ingress {
    protocol    = "tcp"
    from_port   = 443
    to_port     = 443
    cidr_blocks     = ["0.0.0.0/0"]
  }

  ingress {
    protocol    = "tcp"
    from_port   = 80
    to_port     = 80
    cidr_blocks     = ["0.0.0.0/0"]
  }

  ingress {
    from_port = -1
    to_port = -1
    protocol = "icmp"
    cidr_blocks     = ["0.0.0.0/0"]
  }

  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    protocol = "tcp"
    from_port = 8200
    to_port = 8200
  }
}