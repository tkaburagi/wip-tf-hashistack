resource "aws_instance" "consul_ec2" {
  ami = var.ami
  count = var.consul_instance_count
  tags = merge(var.tags, map(
          "Name", "${var.consul_instance_name}-${count.index}-hashistack",
          "Consul_server", "true"
  ))
  instance_type = var.consul_instance_type
  vpc_security_group_ids = [aws_security_group.consul_security_group.id]
  subnet_id = aws_subnet.public.*.id[0]
  key_name = aws_key_pair.deployer.id
  associate_public_ip_address = true

  user_data =<<-EOF
                #!/bin/sh

                cd /home/ubuntu

                sudo apt-get install zip unzip

                wget "${var.consul_dl_url}"

                unzip consul*.zip
                rm consul*.zip
                chmod +x consul

                wget  https://raw.githubusercontent.com/tkaburagi/consul-configs/master/consul-server-cluster-template.json
                sed -e 's/SERVER_NUM_REPLACE/${var.consul_instance_count}/g' consul-server-cluster-template.json > consul-server-cluster.json

                nohup ./consul agent -server -config-dir=/home/ubuntu/consul-server-cluster.json -retry-join "provider=aws tag_key=Consul_server tag_value=true access_key_id=${var.access_key} secret_access_key=${var.secret_key}" > log.out &

              EOF
}