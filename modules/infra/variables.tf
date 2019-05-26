variable "vault_instance_count" {
  default = 1
}
variable "consul_instance_count" {
  default = 1
}

variable "pubkey" {}

variable "ssh_private_key" {}

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

variable "vault_instance_type" {
  default = "t2.micro"
}

variable "ami" {
  default = "ami-64e8fc18"
}

variable "vault_dl_url" {
  default = "https://releases.hashicorp.com/vault/1.1.2/vault_1.1.2_linux_amd64.zip"
}

variable "ssh_key_file" {
  default = "terraform"
}