resource "aws_eip" "eip" {
    provisioner "local-exec" {
        command = "echo \"${aws_eip.eip.public_ip}\" > ip_address.txt"
    }
    tags = {
        Name = var.eip_name
    }
}