resource "aws_instance" "vault_ec2" {
  ami = var.ami
  count = var.vault_instance_count
  instance_type = var.vault_instance_type
  vpc_security_group_ids = [aws_security_group.vault_security_group.id]
  tags = merge(var.tags, map("Name", "${var.vault_instance_name}-${count.index}-hashistack"))
  subnet_id = aws_subnet.public.*.id[0]
  key_name = aws_key_pair.deployer.id
  associate_public_ip_address = true

  user_data =<<-EOF
                #!/bin/sh

                cd /home/ubuntu
                wget "${var.vault_dl_url}"
                wget "${var.consul_dl_url}"


                unzip vault*.zip
                rm vault*zip

                unzip consul*.zip
                rm consul*zip

                chmod +x vault
                chmod +x consul

                wget https://raw.githubusercontent.com/tkaburagi/vault-configs/master/remote-vault-template.hcl

                sed -e 's/CONSUL_ADDR/"${aws_instance.consul_ec2.*.private_dns[count.index]}:8500"/g' remote-vault-template.hcl > remote-vault.hcl

                nohup ./vault server -config /home/ubuntu/remote-vault.hcl &

              EOF
}