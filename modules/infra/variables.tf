variable "vault_instance_count" {
  default = 1
}
variable "consul_instance_count" {
  default = 1
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

variable "vault_instance_type" {
  default = "t2.micro"
}

variable "ami" {
  default = "ami-01dd8d2c0817e2194"
}