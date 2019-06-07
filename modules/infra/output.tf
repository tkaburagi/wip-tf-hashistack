output "vault_public_dns" {
    value = aws_instance.vault_ec2.*.public_dns
}