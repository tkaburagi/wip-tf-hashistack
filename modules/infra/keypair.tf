resource "aws_key_pair" "deployer" {
  public_key = var.pubkey
}