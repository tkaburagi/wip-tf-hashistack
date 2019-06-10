variable "access_key" {}
variable "secret_key" {}
variable "kms_key_id" {}

variable "region" {
  default = "ap-northeast-1"
}

variable "pubkey" {}
variable "ssh_private_key" {}

variable "vault_dl_url" {
  default = "https://releases.hashicorp.com/vault/1.1.2/vault_1.1.2_linux_amd64.zip"
}

variable "consul_dl_url" {
  default = "https://releases.hashicorp.com/consul/1.5.1/consul_1.5.1_linux_amd64.zip"
}

variable "ha_flag" {
  default = false
  //false, cluster(Multi-AZ Cluster), dr(DR:AWS and GCP)
}