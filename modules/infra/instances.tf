resource "aws_instance" "vault_ec2" {
  ami = var.ami
  instance_type = var.vault_instance_type
  vpc_security_group_ids = ["${aws_security_group.vault_security_group.id}"]
//  tags = "${merge(var.tags, map("Name", "${var.web_front_instance_name}"))}"
  subnet_id = "${element(aws_subnet.public.*.id, 0)}"
//  key_name = "${aws_key_pair.deployer.id}"
  associate_public_ip_address = true

//  provisioner "remote-exec" {
//    connection {
//      type = "ssh"
//      user = "ubuntu"
//      private_key = "${file("${var.ssh_key_file}")}"
//    }
//    inline = [
//      "wget ${var.consul_dl_url}",
//      "unzip consul*.zip",
//      "rm consul*.zip",
//      "chmod +x consul"
//    ]
//  }
}