output "vault_public_dns" {
    value = module.infra.vault_public_dns
}

output "vault_alb" {
    value = module.infra.vault_alb
}

output "consul_alb" {
    value = module.infra.consul_alb
}