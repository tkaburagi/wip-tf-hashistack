resource "aws_route53_record" "vault" {
  zone_id = var.aws_route53_zone_id
  name    = "vault.kabuctl.run"
  type    = "CNAME"
  ttl     = "300"
  records = ["${aws_alb.vault_alb.dns_name}"]
}