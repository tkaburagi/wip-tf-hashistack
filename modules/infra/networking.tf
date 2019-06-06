# VPC
resource "aws_vpc" "playground" {
  cidr_block = var.vpc_cidr
  instance_tenancy = "default"
  enable_dns_support = "true"
  enable_dns_hostnames = "true"
}

# Subnet
resource "aws_subnet" "public" {
  vpc_id = aws_vpc.playground.id
  count = length(var.availability_zones)
  cidr_block = var.pubic_subnets_cidr[count.index]
  availability_zone = var.availability_zones[count.index]
  tags = {
    Name = "${var.public_subnet_name}-${count.index}"
  }
}

# EIP
resource "aws_eip" "vault_eip" {
  instance = aws_instance.vault_ec2.id
  count = var.vault_instance_count
  vpc = true
}

resource "aws_eip" "nat" {
  vpc = true
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.playground.id

}

# RouteTable
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.playground.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    Name = "public"
  }
}

# SubnetRouteTableAssociation
resource "aws_route_table_association" "public" {
  count = length(var.pubic_subnets_cidr)
  subnet_id = aws_subnet.public.*.id[0]
  route_table_id = aws_route_table.public.id
}

# NatGateway
resource "aws_nat_gateway" "nat" {
  count = 1
  subnet_id = aws_subnet.public.*.id[0]
  allocation_id = aws_eip.nat.id
}