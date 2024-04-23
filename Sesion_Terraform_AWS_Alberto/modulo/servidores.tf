data "aws_subnet" "red-pro-geeks1" {
  filter {
    name   = "vpc-id"
    values = ["vpc-0f2e2ad653ca1c092"]
  }

  tags = {
    Name = "subred-geeks1-servidores-pro"
  }
}

resource "aws_instance" "servidor-green-web-geeks1" {
  count                   = var.green_enabled ? 1 : 0
  instance_type           = "t3a.medium"
  ami                     = "ami-07b9b3580fd50d52d"
  subnet_id               = data.aws_subnet.red-pro-geeks1.id
  vpc_security_group_ids  = ["sg-0dc575e80dd36ad2c"]
  key_name                = aws_key_pair.key.key_name
  disable_api_termination = false
  ebs_optimized           = false
  user_data               = file("templates/nginx.sh")

  root_block_device {
    volume_size = "10"
  }

  tags = {
    "Name" = "servidor-nginx-green-geeks1"
  }
}

resource "aws_instance" "servidor-blue-web-geeks1" {
  count                   = !var.green_enabled ? 1 : 0
  instance_type           = "t3a.medium"
  ami                     = "ami-07b9b3580fd50d52d"
  subnet_id               = data.aws_subnet.red-pro-geeks1.id
  vpc_security_group_ids  = ["sg-0dc575e80dd36ad2c"]
  key_name                = aws_key_pair.key.key_name
  disable_api_termination = false
  ebs_optimized           = false
  user_data               = file("templates/nginx.sh")

  root_block_device {
    volume_size = "20"
  }

  tags = {
    "Name" = "servidor-nginx-blue-geeks1"
  }
}
