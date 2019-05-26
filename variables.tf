variable "access_key" {}
variable "secret_key" {}

variable "region" {
  default = "ap-northeast-1"
}

variable "pubkey" {}
variable "ssh_private_key" {}

variable "vault_dl_url" {
  default = "https://releases.hashicorp.com/vault/1.1.2/vault_1.1.2_linux_amd64.zip"
}