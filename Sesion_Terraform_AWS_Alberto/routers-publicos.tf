############## IPS PUBLICAS VPC ################

resource "aws_eip" "ip-publica-red-geeks1" {
  domain = "vpc"
  tags = {
    "Name" = "ip-internet-geeks1"
  }
  depends_on = [aws_internet_gateway.router-internet-red-geeks1]
}

resource "aws_eip" "ip-publica-red-geeks2" {
  domain = "vpc"
  tags = {
    "Name" = "ip-internet-geeks2"
  }
  depends_on = [aws_internet_gateway.router-internet-red-geeks2]
}

############### ROUTERS DE INTERNET ####################

resource "aws_internet_gateway" "router-internet-red-geeks1" {
  vpc_id = aws_vpc.red-geeks1.id
  tags = {
    Name = "router-publico-vpc-geeks1"
  }
}

resource "aws_internet_gateway" "router-internet-red-geeks2" {
  vpc_id = aws_vpc.red-geeks2.id
  tags = {
    Name = "router-publico-vpc-geeks2"
  }
}

resource "aws_nat_gateway" "nat-red-geeks1" {
  allocation_id = aws_eip.ip-publica-red-geeks1.id
  subnet_id     = aws_subnet.subred-publica-red-geeks1.id
  tags = {
    "Name" = "nat-red-geeks1"
  }
  depends_on = [aws_internet_gateway.router-internet-red-geeks1]
}

resource "aws_nat_gateway" "nat-red-geeks2" {
  allocation_id = aws_eip.ip-publica-red-geeks2.id
  subnet_id     = aws_subnet.subred-publica-red-geeks2.id
  tags = {
    "Name" = "nat-red-geeks2"
  }
  depends_on = [aws_internet_gateway.router-internet-red-geeks2]
}


