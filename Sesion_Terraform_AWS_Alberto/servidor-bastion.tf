resource "aws_instance" "servidor-bastion-geeks1" {
  instance_type           = "t3a.medium"
  ami                     = var.ami-rocky-linux
  subnet_id               = aws_subnet.subred-publica-red-geeks1.id
  vpc_security_group_ids  = ["${aws_security_group.red-geeks1-firewall.id}"]
  key_name                = aws_key_pair.key.key_name
  disable_api_termination = false
  ebs_optimized           = false
  user_data               = file("templates/bastion.sh")

  root_block_device {
    volume_size = "10"
  }

  provisioner "local-exec" {
    command = "echo ${self.private_ip} >> private_ip.txt"
  }

  #connection {
  #  type = "ssh"
  #  user = "rocky"
  #  host = self.public_ip
  #}

  #provisioner "remote-exec" {
  #  inline = [
  #    "chown rocky /home/rocky",
  #
  #    ]
  #  }

  tags = {
    "Name" = "servidor-bastion-geeks1"
  }
}

resource "aws_instance" "servidor-bastion-geeks2" {
  instance_type           = "t3a.medium"
  ami                     = var.ami-rocky-linux
  subnet_id               = aws_subnet.subred-publica-red-geeks2.id
  vpc_security_group_ids  = ["${aws_security_group.red-geeks2-firewall.id}"]
  key_name                = aws_key_pair.key.key_name
  disable_api_termination = false
  ebs_optimized           = false
  user_data               = file("templates/bastion.sh")

  root_block_device {
    volume_size = "10"
  }


  #provisioner "file" {
  #  source      = "../keystore/id_rsa"
  #  destination = "/home/rocky/id_rsa"
  #}
  tags = {
    "Name" = "servidor-bastion-geeks2"
  }
}
