resource "aws_ebs_volume" "ebs_volume" {
  availability_zone = var.ebs_zone
  size              = var.ebs_size
  tags              = var.ebs_tags
}