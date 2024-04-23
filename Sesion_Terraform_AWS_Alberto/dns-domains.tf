resource "aws_route53_zone" "dominios-dns-privados-red-geeks1" {
  count = length(var.dns-domains)
  name  = element(var.dns-domains, count.index)

  vpc {
    vpc_id = aws_vpc.red-geeks1.id
  }

  tags = {
    Zone = replace(element(var.dns-domains, count.index), ".", "-")
  }
}

resource "aws_route53_zone" "dominios-dns-privados-red-geeks2" {
  count = length(var.dns-domains)
  name  = element(var.dns-domains, count.index)

  vpc {
    vpc_id = aws_vpc.red-geeks2.id
  }

  tags = {
    Zone = replace(element(var.dns-domains, count.index), ".", "-")
  }
}
