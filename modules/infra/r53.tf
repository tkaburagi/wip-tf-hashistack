resource "aws_route53_record" "vault" {
  zone_id = var.aws_route53_zone_id
  name    = var.vault_fqdn
  type    = "CNAME"
  ttl     = "300"
  records = [aws_alb.vault_alb.dns_name]
}

resource "aws_route53_record" "consul" {
  zone_id = var.aws_route53_zone_id
  name    = var.consul_fqdn
  type    = "CNAME"
  ttl     = "300"
  records = [aws_alb.consul_alb.dns_name]
}

provider "aws" {
  access_key = var.access_key
  secret_key = var.secret_key
  region     = "ap-northeast-1"
}