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

provider "aws" {
  access_key = var.access_key
  secret_key = var.secret_key
  region     = var.region
}

module "infra" {
  source = "./modules/infra"
  ssh_private_key = var.ssh_private_key
  pubkey = var.pubkey
  vault_dl_url = var.vault_dl_url
}