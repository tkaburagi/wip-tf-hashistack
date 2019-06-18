variable "access_key" {}
variable "secret_key" {}
variable "kms_key_id" {}
variable "ha_flag" {}
variable "pubkey" {}
variable "ssh_private_key" {}
variable "vault_instance_type" {}
variable "consul_instance_type" {}
variable "vault_dl_url" {}
variable "consul_dl_url" {}
variable "vault_instance_count_ha" {}
variable "consul_instance_count_ha" {}
variable "vault_instance_count" {}
variable "consul_instance_count" {}
variable "grafana_pw" {}

variable "vault_url" {
  default = "vault.kabuctl.run"
}

variable "consul_url" {
  default = "consul.kabuctl.run"
}

variable "availability_zones" {
  type = "list"
  default = ["ap-northeast-1a", "ap-northeast-1c"]
}

variable "vpc_cidr" {
  default = "10.10.0.0/16"
}

variable "pubic_subnets_cidr" {
  type = "list"
  default = ["10.10.0.0/24", "10.10.1.0/24"]
}

variable "public_subnet_name" {
  default = "public"
}

variable "ami" {
  default = "ami-06d9ad3f86032262d"
}


variable "aws_route53_zone_id" {
  default = "Z1P2KB2X8LWEX"
}

variable "consul_instance_name" {
  default = "consul"
}

variable "vault_instance_name" {
  default = "vault"
}

variable "tags" {
  type        = "map"
  default     = {}
  description = "Key/value tags to assign to all AWS resources"
}