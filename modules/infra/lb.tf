resource "aws_alb" "vault_alb" {
  name = "vault-alb"
  internal = false
  subnets = "${aws_subnet.public.*.id}"
  security_groups = ["${aws_security_group.vault_security_group.id}"]
  subnet_mapping {
    subnet_id     = "${aws_subnet.public.0.id}"
    allocation_id = "eipalloc-0df5c585eabf14148"
  }
}

resource "aws_alb_target_group" "vault_tg" {
  name = "vault-tg"
  port = 8200
  protocol = "HTTP"
  vpc_id = "${aws_vpc.playground.id}"

  health_check {
    protocol = "HTTP"
  }
}

resource "aws_alb_target_group_attachment" "alb_attche_tg_boot" {
  target_group_arn = "${aws_alb_target_group.vault_tg.arn}"
  target_id = "${aws_instance.vault_ec2.id}"
  port = 8200
}

# Listener for HTTP/HTTPS
resource "aws_alb_listener" "web_80" {
  load_balancer_arn = "${aws_alb.vault_alb.arn}"
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = "${aws_alb_target_group.vault_tg.arn}"
  }
}

