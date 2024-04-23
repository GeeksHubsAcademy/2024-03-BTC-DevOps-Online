######### busquedas y filtros ############
data "aws_availability_zones" "available-zones" {
  state = "available"
}

data "aws_subnets" "subredes-vpc-geeks1" {
  filter {
    name   = "vpc-id"
    values = [aws_vpc.red-geeks1.id]
  }
}

data "aws_subnets" "subredes-vpc-geeks2" {
  filter {
    name   = "vpc-id"
    values = [aws_vpc.red-geeks2.id]
  }
}

############# VPCS Y SUBREDES ################

resource "aws_vpc" "red-geeks1" {
  cidr_block = var.ipcidr-redgeeks1
  #cidr_block      = "10.132.0.0/16" 
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "red-geeks1"
  }
}

resource "aws_vpc" "red-geeks2" {
  cidr_block = var.ipcidr-redgeeks2
  #cidr_block      = "10.133.0.0/16" 
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "red-geeks2"
  }
}

resource "aws_subnet" "subredes-geeks1" {
  for_each                = var.subredes-geeks1
  vpc_id                  = aws_vpc.red-geeks1.id
  cidr_block              = each.value.cidr
  availability_zone       = data.aws_availability_zones.available-zones.names[each.value.zone]
  map_public_ip_on_launch = false
  tags = {
    Name = "${each.value.tag}"
    Tipo = "privada"
  }
}

resource "aws_subnet" "subredes-geeks2" {
  for_each                = var.subredes-geeks2
  vpc_id                  = aws_vpc.red-geeks2.id
  cidr_block              = each.value.cidr
  availability_zone       = data.aws_availability_zones.available-zones.names[each.value.zone]
  map_public_ip_on_launch = false
  tags = {
    Name = "${each.value.tag}"
    Tipo = "privada"
  }
}


resource "aws_subnet" "subred-publica-red-geeks1" {
  vpc_id                  = aws_vpc.red-geeks1.id
  cidr_block              = var.subred-publica-geeks1-cidr
  availability_zone       = data.aws_availability_zones.available-zones.names[0]
  map_public_ip_on_launch = true # ip publica
  tags = {
    Name = "subred-red-geeks1-publica"
    Tipo = "publica"
  }
}

resource "aws_subnet" "subred-publica-red-geeks2" {
  vpc_id                  = aws_vpc.red-geeks2.id
  cidr_block              = var.subred-publica-geeks2-cidr
  availability_zone       = data.aws_availability_zones.available-zones.names[0]
  map_public_ip_on_launch = true # ip publica
  tags = {
    Name = "subred-red-geeks2-publica"
    Tipo = "publica"
  }
}





