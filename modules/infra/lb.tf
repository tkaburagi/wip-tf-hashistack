resource "aws_alb" "vault_alb" {
  name = "vault-alb"
  internal = false
  subnets = aws_subnet.public.*.id
  security_groups = [aws_security_group.vault_security_group.id]
}

resource "aws_alb" "consul_alb" {
  name = "consul-alb"
  internal = false
  subnets = aws_subnet.public.*.id
  security_groups = [aws_security_group.consul_security_group.id]
}

resource "aws_alb_target_group" "vault_tg" {
  name = "vault-tg"
  port = 8200
  protocol = "HTTP"
  vpc_id = aws_vpc.playground.id

  health_check {
    protocol = "HTTP"
  }
}

resource "aws_alb_target_group" "consul_tg" {
  name = "consul-tg"
  port = 8500
  protocol = "HTTP"
  vpc_id = aws_vpc.playground.id

  health_check {
    protocol = "HTTP"
  }
}

resource "aws_alb_target_group_attachment" "alb_attach_tg_vault" {
  count = var.vault_instance_count
  target_group_arn = aws_alb_target_group.vault_tg.arn
  target_id = aws_instance.vault_ec2.*.id[count.index]
  port = 8200
}


resource "aws_alb_target_group_attachment" "alb_attach_tg_consul" {
  count = var.consul_instance_count
  target_group_arn = aws_alb_target_group.consul_tg.arn
  target_id = aws_instance.consul_ec2.*.id[count.index]
  port = 8500
}

# Listener for HTTP/HTTPS
resource "aws_alb_listener" "http_vault" {
  load_balancer_arn = aws_alb.vault_alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.vault_tg.arn
  }
}

resource "aws_alb_listener" "http_consul" {
  load_balancer_arn = aws_alb.consul_alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.consul_tg.arn
  }
}