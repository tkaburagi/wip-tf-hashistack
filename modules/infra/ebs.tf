//resource "aws_volume_attachment" "ebs_att_consul" {
//    count = var.consul_instance_count
//    device_name = "/dev/sdh"
//    volume_id   = aws_ebs_volume.ebs_consul.*.id[count.index]
//    instance_id = aws_instance.consul_ec2.*.public_dns[count.index]
//}
//
//resource "aws_volume_attachment" "ebs_att_vault" {
//    count = var.vault_instance_count
//    device_name = "/dev/sdh"
//    volume_id   = aws_ebs_volume.ebs_vault.*.id[count.index]
//    instance_id = aws_instance.vault_ec2.*.public_dns[count.index]
//}
//
//resource "aws_ebs_volume" "ebs_consul" {
//    count = var.consul_instance_count
//    availability_zone = "ap-northeast-1a"
//    size              = 10
//}
//
//resource "aws_ebs_volume" "ebs_vault" {
//    count = var.vault_instance_count
//    availability_zone = "ap-northeast-1a"
//    size              = 10
//}