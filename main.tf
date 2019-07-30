terraform {
  required_version = " 0.12.0"
  backend "remote" {
    hostname = "app.terraform.io"
    organization = "tkaburagi"

    workspaces {
      name = "hashistack"
    }
  }
}

module "infra" {
  source = "./modules/infra"
  providers "aws" {
    access_key = var.access_key
    secret_key = var.secret_key
    region     = var.region
  }
  kms_key_id = var.kms_key_id
  access_key = var.access_key
  secret_key = var.secret_key
  ssh_private_key = var.ssh_private_key
  pubkey = var.pubkey
  vault_dl_url = var.vault_dl_url
  consul_dl_url = var.consul_dl_url
  ha_flag = var.ha_flag
  vault_instance_count_ha = var.vault_instance_count_ha
  consul_instance_count_ha = var.consul_instance_count_ha
  vault_instance_count = var.ha_flag == "false" ? 1 : var.vault_instance_count_ha
  consul_instance_count = var.ha_flag == "false" ? 1 : var.consul_instance_count_ha
  grafana_pw = var.grafana_pw
  vault_fqdn = var.vault_fqdn
  consul_fqdn = var.consul_fqdn
}