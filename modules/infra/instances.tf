resource "aws_instance" "vault_ec2" {
  ami = var.ami
  instance_type = var.vault_instance_type
  vpc_security_group_ids = ["${aws_security_group.vault_security_group.id}"]
//  tags = "${merge(var.tags, map("Name", "${var.web_front_instance_name}"))}"
  subnet_id = "${element(aws_subnet.public.*.id, 0)}"
  key_name = "${aws_key_pair.deployer.id}"
  associate_public_ip_address = true

  provisioner "local-exec" {
    command = "ls -ltrR && cat generate-vault.config.sh"
  }

  provisioner "remote-exec" {
    connection {
      host = "${aws_instance.vault_ec2.public_ip}"
      type = "ssh"
      user = "ubuntu"
      private_key = var.ssh_private_key
    }
    inline = [
      "wget ${var.vault_dl_url}",
      "unzip vault*.zip",
      "rm vault*.zip",
      "chmod +x vault",
      "ls -ltr",
      "nohup vault server -dev &",
      "echo ${aws_instance.vault_ec2.private_ip} >> private_ips.txt",
      "cat private_ips.txt"
    ]
  }
}