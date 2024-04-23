data "aws_subnet" "red-pro-geeks1" {
  filter {
    name   = "vpc-id"
    values = [aws_vpc.red-geeks1.id]
  }

  tags = {
    Name = "subred-geeks1-servidores-pro"
  }
}

data "aws_subnet" "red-pro-geeks2" {
  filter {
    name   = "vpc-id"
    values = [aws_vpc.red-geeks2.id]
  }

  tags = {
    Name = "subred-geeks2-servidores-pro"
  }
}

resource "aws_instance" "servidor-web-geeks1" {
  instance_type           = "t3a.medium"
  ami                     = var.ami-rocky-linux
  subnet_id               = data.aws_subnet.red-pro-geeks1.id
  vpc_security_group_ids  = ["${aws_security_group.red-geeks1-firewall.id}"]
  key_name                = aws_key_pair.key.key_name
  disable_api_termination = false
  ebs_optimized           = false
  user_data               = file("templates/nginx.sh")

  root_block_device {
    volume_size = "10"
  }

  tags = {
    "Name" = "servidor-nginx-geeks1"
  }
}


resource "aws_instance" "servidor-web-geeks2" {
  instance_type           = "t3a.medium"
  ami                     = var.ami-rocky-linux
  subnet_id               = data.aws_subnet.red-pro-geeks2.id
  vpc_security_group_ids  = ["${aws_security_group.red-geeks2-firewall.id}"]
  key_name                = aws_key_pair.key.key_name
  disable_api_termination = false
  ebs_optimized           = false
  user_data               = file("templates/nginx.sh")

  root_block_device {
    volume_size = "10"
  }

  tags = {
    "Name" = "servidor-nginx-geeks2"
  }
}
