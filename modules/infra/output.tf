output "vault_public_dns" {
    value = aws_instance.vault_ec2.*.public_dns
}

output "vault_alb" {
    value = aws_alb.vault_alb.dns_name
}

output "consul_alb" {
    value = aws_alb.consul_alb.dns_name
}