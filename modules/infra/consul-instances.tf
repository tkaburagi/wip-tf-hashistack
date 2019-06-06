resource "aws_instance" "consul_ec2" {
  ami = var.ami
  instance_type = var.vault_instance_type
  vpc_security_group_ids = [
    aws_security_group.vault_security_group.id]
  //  tags = "${merge(var.tags, map("Name", "${var.web_front_instance_name}"))}"
  subnet_id = aws_subnet.public.*.id[0]
  key_name = aws_key_pair.deployer.id
  associate_public_ip_address = true
  user_data = file("generate-vault-config.sh")

}