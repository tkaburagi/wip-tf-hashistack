resource "aws_instance" "vault_ec2" {
  ami = var.ami
  count = var.vault_instance_count
  instance_type = var.vault_instance_type
  vpc_security_group_ids = [aws_security_group.vault_security_group.id]
  tags = merge(var.tags, map("Name", "${var.vault_instance_name}-${count.index}-hashistack"))
  subnet_id = aws_subnet.public.*.id[0]
  key_name = aws_key_pair.deployer.id
  associate_public_ip_address = true

  provisioner "file" {
    connection {
      type = "ssh"
      user = "ubuntu"
      private_key = var.ssh_private_key
      host = self.public_dns
    }
    source      = "/Users/kabu/hashicorp/vault/scripts/replacer.sh"
    destination = "/home/ubuntu/replacer.sh"
  }

//  provisioner "remote-exec" {
//    connection {
//      type = "ssh"
//      user = "ubuntu"
//      private_key = var.ssh_private_key
//      host = self.public_dns
//    }
//      inline = [
//        "export SERVER_NUM_REPLACE=${var.vault_instance_count}",
//        "export SERVICE_NAME_REPLACE=${var.vault_instance_name}",
//        "export API_ADDR_REPLACE=http://${var.vault_url}",
//        "export CLUSTER_ADDR_REPLACE=https://${var.vault_instance_name}.service.dc1.consul:8201",
//        "chmod +x /home/ubuntu/replacer.sh",
//        "/home/ubuntu/replacer.sh"
//      ]
//  }

  user_data =<<-EOF
                #!/bin/sh

                cd /home/ubuntu

                sudo apt-get install zip unzip

                wget "${var.vault_dl_url}"
                wget "${var.consul_dl_url}"
                wget https://raw.githubusercontent.com/tkaburagi/vault-configs/master/remote-vault-template.hcl
                wget https://raw.githubusercontent.com/tkaburagi/consul-configs/master/consul-client-cluster-template.json

                unzip vault*.zip
                rm vault*zip

                unzip consul*.zip
                rm consul*zip

                chmod +x vault
                chmod +x consul

                export SERVER_NUM_REPLACE=${var.vault_instance_count}
                export SERVICE_NAME_REPLACE=${var.vault_instance_name}
                export API_ADDR_REPLACE=http://${var.vault_url}
                export CLUSTER_ADDR_REPLACE=https://${var.vault_instance_name}.service.dc1.consul:8201
                export VAULT_AWSKMS_SEAL_KEY_ID=${var.kms_key_id}
                export AWS_SECRET_ACCESS_KEY=${var.secret_key}
                export AWS_ACCESS_KEY_ID=${var.access_key}

                sed "s|SERVER_NUM_REPLACE|`echo $SERVER_NUM_REPLACE`|g" consul-client-cluster-template.json > consul-client-cluster.json
                sed "s|SERVICE_NAME_REPLACE|`echo $SERVICE_NAME_REPLACE`|g" remote-vault-template.hcl > remote-vault-template-2.hcl
                sed "s|API_ADDR_REPLACE|`echo $API_ADDR_REPLACE`|g" remote-vault-template-2.hcl > remote-vault-template-3.hcl
                sed "s|CLUSTER_ADDR_REPLACE|`echo $CLUSTER_ADDR_REPLACE`|g" remote-vault-template-3.hcl > remote-vault.hcl

                sleep 60

                nohup ./consul agent -config-dir=/home/ubuntu/consul-client-cluster.json -retry-join "provider=aws tag_key=Consul_server tag_value=true access_key_id=${var.access_key} secret_access_key=${var.secret_key}" > consul.log &
                nohup ./vault server -config /home/ubuntu/remote-vault.hcl > vault.log &

              EOF
}
