locals {
  ingress-geeks1 = {
    for rule in keys(var.reglasFW-geeks1-ingress) :
    rule => lookup(var.reglasFW-geeks1-ingress, rule)
  }
}

locals {
  egress-geeks1 = {
    for rule in keys(var.reglasFW-geeks1-egress) :
    rule => lookup(var.reglasFW-geeks1-egress, rule)
  }
}

locals {
  ingress-geeks2 = {
    for rule in keys(var.reglasFW-geeks2-ingress) :
    rule => lookup(var.reglasFW-geeks2-ingress, rule)
  }
}

locals {
  egress-geeks2 = {
    for rule in keys(var.reglasFW-geeks2-egress) :
    rule => lookup(var.reglasFW-geeks2-egress, rule)
  }
}


resource "aws_security_group" "red-geeks1-firewall" {
  name        = "firewall-red-geeks1"
  description = "trafico permitido red geeks1"
  vpc_id      = aws_vpc.red-geeks1.id

  dynamic "ingress" {
    for_each = local.ingress-geeks1
    content {
      from_port   = lookup(ingress.value, "from_port", null)
      to_port     = lookup(ingress.value, "to_port", null)
      protocol    = lookup(ingress.value, "protocol", null)
      cidr_blocks = lookup(ingress.value, "cidr", null)
      description = lookup(ingress.value, "description", null)
    }
  }

  dynamic "egress" {
    for_each = local.egress-geeks1
    content {
      from_port   = lookup(egress.value, "from_port", null)
      to_port     = lookup(egress.value, "to_port", null)
      protocol    = lookup(egress.value, "protocol", null)
      cidr_blocks = lookup(egress.value, "cidr", null)
      description = lookup(egress.value, "description", null)
    }
  }

    #lifecycle {
     # ignore_changes = all
    #}
}

resource "aws_security_group" "red-geeks2-firewall" {
  name        = "firewall-red-geeks2"
  description = "trafico permitido red geeks2"
  vpc_id      = aws_vpc.red-geeks2.id

  dynamic "ingress" {
    for_each = local.ingress-geeks2
    content {
      from_port   = lookup(ingress.value, "from_port", null)
      to_port     = lookup(ingress.value, "to_port", null)
      protocol    = lookup(ingress.value, "protocol", null)
      cidr_blocks = lookup(ingress.value, "cidr", null)
      description = lookup(ingress.value, "description", null)
    }
  }

  dynamic "egress" {
    for_each = local.egress-geeks2
    content {
      from_port   = lookup(egress.value, "from_port", null)
      to_port     = lookup(egress.value, "to_port", null)
      protocol    = lookup(egress.value, "protocol", null)
      cidr_blocks = lookup(egress.value, "cidr", null)
      description = lookup(egress.value, "description", null)
    }
  }

  #  lifecycle {
  #    ignore_changes = all
  #  }
}
