resource "aws_instance" "ec2" {
  ami           = var.ami
  instance_type = var.instance_type
  key_name      = var.key_name
  availability_zone = var.availability_zone
  security_groups =[ "${var.security_group_name}" ]
  tags = {
    Name = var.tag_name
  }

  root_block_device {
    volume_size = 10
    volume_type = "gp2"
    encrypted = true
    delete_on_termination = true
  }
  provisioner "local-exec" {
    command = "echo PUBLIC IP: ${self.public_ip} >> IP_ec2.txt"

  }
  provisioner "remote-exec" {
    script = "../app/files/install.sh"

    connection {
      type        = "ssh"
      user        = var.user
      host        = self.public_ip
      private_key = file("../app/files/${var.key_name}.pem")
      
    }
  }
}
