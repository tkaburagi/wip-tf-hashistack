resource "aws_instance" "consul_ec2" {
  ami = var.ami
  count = var.consul_instance_count
  tags = merge(var.tags, map("Name", "${var.consul_instance_name}-${count.index}"))
  instance_type = var.consul_instance_type
  vpc_security_group_ids = [aws_security_group.consul_security_group.id]
   subnet_id = aws_subnet.public.*.id[0]
  key_name = aws_key_pair.deployer.id
  associate_public_ip_address = true
  user_data =<<-EOF
                #!/bin/sh

                cd /home/ubuntu
                wget "${var.consul_dl_url}"

                unzip consul*.zip
                rm consul*.zip
                chmod +x consul

                wget  https://raw.githubusercontent.com/tkaburagi/consul-configs/master/scocat.json

                nohup ./consul agent -server -bind=0.0.0.0 -client=0.0.0.0 -data-dir=/home/ubuntu/localdata -bootstrap-expect=1 -ui -config-file=/home/ubuntu/scocat.json &

              EOF
}