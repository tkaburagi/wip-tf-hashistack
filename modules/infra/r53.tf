resource "aws_route53_zone" "primary" {
  name = "kabuctl.run"
}

resource "aws_route53_record" "vault" {
  zone_id = "${aws_route53_zone.primary.id}"
  name    = "vault.kabuctl.run"
  type    = "CNAME"
  ttl     = "300"
  records = ["${aws_alb.vault_alb.dns_name}"]
}