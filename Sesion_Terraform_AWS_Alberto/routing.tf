#################### BUSQUEDAS #################### 

data "aws_subnets" "redes-privadas-geeks1" {
  filter {
    name   = "vpc-id"
    values = [aws_vpc.red-geeks1.id]
  }

  tags = {
    Tipo = "privada"
  }

}

data "aws_subnets" "redes-privadas-geeks2" {
  filter {
    name   = "vpc-id"
    values = [aws_vpc.red-geeks2.id]
  }

  tags = {
    Tipo = "privada"
  }
}

##################### ROUTING #####################

resource "aws_route_table" "routing-red-geeks1-privada" {
  vpc_id = aws_vpc.red-geeks1.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat-red-geeks1.id
  }
  tags = {
    Name = "routing-privado-red-geeks1"
  }

  #lifecycle {
  #        ignore_changes = [route]
  #}
}

resource "aws_route_table" "routing-red-geeks2-privada" {
  vpc_id = aws_vpc.red-geeks2.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat-red-geeks2.id
  }
  tags = {
    Name = "routing-privado-red-geeks2"
  }

  #lifecycle {
  #        ignore_changes = [route]
  #}
}

resource "aws_route_table" "routing-red-geeks1-publica" {
  vpc_id = aws_vpc.red-geeks1.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.router-internet-red-geeks1.id
  }
  tags = {
    Name = "routing-publico-red-geeks1"
  }

  #lifecycle {
  #        ignore_changes = [route]
  #}
}

resource "aws_route_table" "routing-red-geeks2-publica" {
  vpc_id = aws_vpc.red-geeks2.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.router-internet-red-geeks2.id
  }
  tags = {
    Name = "routing-publico-red-geeks2"
  }

  #lifecycle {
  #        ignore_changes = [route]
  #}
}


resource "aws_route" "ruta-peering-geeks1-to-geeks2" {
  route_table_id         = aws_route_table.routing-red-geeks1-privada.id
  destination_cidr_block = var.ipcidr-redgeeks2
  #vpc_peering_connection_id = "pcx-04f1c32b6e174b474"
  #vpc_peering_connection_id = aws_vpc_peering_connection.peering-geeks2-to-geeks1.id
  vpc_peering_connection_id = aws_vpc_peering_connection.peering-geeks1-to-geeks2.id
}

resource "aws_route" "ruta-peering-geeks2-to-geeks1" {
  route_table_id         = aws_route_table.routing-red-geeks2-privada.id
  destination_cidr_block = var.ipcidr-redgeeks1
  #  vpc_peering_connection_id = "pcx-04f1c32b6e174b474"
  #  vpc_peering_connection_id = aws_vpc_peering_connection.peering-geeks2-to-geeks1.id
  vpc_peering_connection_id = aws_vpc_peering_connection.peering-geeks1-to-geeks2.id
}

resource "aws_route" "ruta-peering-geeks1-to-geeks2-publico" {
  route_table_id         = aws_route_table.routing-red-geeks1-publica.id
  destination_cidr_block = var.subred-publica-geeks2-cidr
  #vpc_peering_connection_id = "pcx-04f1c32b6e174b474"
  #vpc_peering_connection_id = aws_vpc_peering_connection.peering-geeks2-to-geeks1.id
  vpc_peering_connection_id = aws_vpc_peering_connection.peering-geeks1-to-geeks2.id
}

resource "aws_route" "ruta-peering-geeks2-to-geeks1-publico" {
  route_table_id         = aws_route_table.routing-red-geeks2-publica.id
  destination_cidr_block = var.subred-publica-geeks1-cidr
  #  vpc_peering_connection_id = "pcx-04f1c32b6e174b474"
  #  vpc_peering_connection_id = aws_vpc_peering_connection.peering-geeks2-to-geeks1.id
  vpc_peering_connection_id = aws_vpc_peering_connection.peering-geeks1-to-geeks2.id
}


resource "aws_route_table_association" "tabla-rutas-geeks1" {
  for_each       = toset(data.aws_subnets.redes-privadas-geeks1.ids)
  subnet_id      = each.value
  route_table_id = aws_route_table.routing-red-geeks1-privada.id
}

resource "aws_route_table_association" "tabla-rutas-geeks2" {
  for_each       = toset(data.aws_subnets.redes-privadas-geeks2.ids)
  subnet_id      = each.value
  route_table_id = aws_route_table.routing-red-geeks2-privada.id
}

resource "aws_route_table_association" "tabla-rutas-geeks1-subred-publica" {
  subnet_id      = aws_subnet.subred-publica-red-geeks1.id
  route_table_id = aws_route_table.routing-red-geeks1-publica.id
}

resource "aws_route_table_association" "tabla-rutas-geeks2-subred-publica" {
  subnet_id      = aws_subnet.subred-publica-red-geeks2.id
  route_table_id = aws_route_table.routing-red-geeks2-publica.id
}

resource "aws_vpc_peering_connection" "peering-geeks1-to-geeks2" {
  peer_owner_id = "268229342313"
  peer_vpc_id   = aws_vpc.red-geeks2.id
  vpc_id        = aws_vpc.red-geeks1.id
  peer_region   = var.region
}

resource "aws_vpc_peering_connection" "peering-geeks2-to-geeks1" {
  peer_owner_id = "268229342313"
  peer_vpc_id   = aws_vpc.red-geeks1.id
  vpc_id        = aws_vpc.red-geeks2.id
  peer_region   = var.region
}
