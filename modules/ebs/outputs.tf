output "ebs_id" {
    value = aws_ebs_volume.ebs_volume.id
}
output "ebs_zone" {
    value = aws_ebs_volume.ebs_volume.availability_zone
}