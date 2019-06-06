# Vault
resource "aws_security_group" "vault_security_group" {
  name = "vault_security_group"
  description = "Vault Sercuriy Group"
  vpc_id = aws_vpc.playground.id

  ingress {
    from_port = -1
    to_port = -1
    protocol = "icmp"
    cidr_blocks     = ["0.0.0.0/0"]
  }

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
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    from_port = 8200
    to_port = 8200
  }

  egress {
    cidr_blocks = ["0.0.0.0/0"]
    protocol = "-1"
    from_port = 0
    to_port = 0
  }
}

resource "aws_security_group" "consul_security_group" {
  name = "consul_security_group"
  description = "Consul Sercuriy Group"
  vpc_id = aws_vpc.playground.id

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
    cidr_blocks = ["0.0.0.0/0"]
    protocol = "tcp"
    from_port = 8500
    to_port = 8500
  }

  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    protocol = "tcp"
    from_port = 8300
    to_port = 8300
  }

  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    protocol = "tcp"
    from_port = 8600
    to_port = 8600
  }

  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    protocol = "tcp"
    from_port = 8301
    to_port = 8301
  }

  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    protocol = "tcp"
    from_port = 8302
    to_port = 8302
  }

  ingress {
    from_port = -1
    to_port = -1
    protocol = "icmp"
    cidr_blocks     = ["0.0.0.0/0"]
  }

  egress {
    cidr_blocks = ["0.0.0.0/0"]
    protocol = "-1"
    from_port = 0
    to_port = 0
  }
}