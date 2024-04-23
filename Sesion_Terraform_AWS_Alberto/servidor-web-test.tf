data "aws_subnet" "red-test-geeks1" {
  filter {
    name   = "vpc-id"
    values = [aws_vpc.red-geeks1.id]
  }

  tags = {
    Name = "subred-geeks1-servidores-test"
  }
}

data "aws_subnet" "red-test-geeks2" {
  filter {
    name   = "vpc-id"
    values = [aws_vpc.red-geeks1.id]
  }

  tags = {
    Name = "subred-geeks2-servidores-test"
  }
}

data "aws_subnet" "red-staging-geeks1" {
  filter {
    name   = "vpc-id"
    values = [aws_vpc.red-geeks1.id]
  }

  tags = {
    Name = "subred-geeks1-servidores-staging"
  }
}

data "aws_subnet" "red-staging-geeks2" {
  filter {
    name   = "vpc-id"
    values = [aws_vpc.red-geeks2.id]
  }

  tags = {
    Name = "subred-geeks2-servidores-staging"
  }
}



resource "aws_instance" "servidor-web-tests-staging-geeks1" {
  instance_type           = "t2.micro"
  ami                     = var.ami-rocky-linux
  subnet_id               = terraform.workspace == "test" ? data.aws_subnet.red-test-geeks1.id : data.aws_subnet.red-staging-geeks1.id
  vpc_security_group_ids  = ["${aws_security_group.red-geeks1-firewall.id}"]
  key_name                = aws_key_pair.key.key_name
  disable_api_termination = false
  ebs_optimized           = false
  user_data               = file("templates/nginx.sh")

  root_block_device {
    volume_size = "10"
  }

  tags = {
    "Name" = terraform.workspace == "test" ? "servidor-nginx-test-geeks1" : "servidor-nginx-staging-geeks1"
  }
}


resource "aws_instance" "servidor-web-tests-taging-geeks2" {
  instance_type           = "t2.micro"
  ami                     = var.ami-rocky-linux
  subnet_id               = terraform.workspace == "test" ? data.aws_subnet.red-test-geeks1.id : data.aws_subnet.red-staging-geeks1.id
  vpc_security_group_ids  = ["${aws_security_group.red-geeks2-firewall.id}"]
  key_name                = aws_key_pair.key.key_name
  disable_api_termination = false
  ebs_optimized           = false
  user_data               = file("templates/nginx.sh")

  root_block_device {
    volume_size = "10"
  }

  tags = {
    "Name" = terraform.workspace == "test" ? "servidor-nginx-test-geeks2" : "servidor-nginx-staging-geeks2"
  }
}
