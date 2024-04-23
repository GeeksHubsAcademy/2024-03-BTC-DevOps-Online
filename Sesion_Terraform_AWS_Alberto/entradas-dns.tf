data "aws_route53_zone" "selected-mygeeks1" {
  name         = "myredgeeks1.es."
  vpc_id       = aws_vpc.red-geeks1.id
  private_zone = true
}

data "aws_route53_zone" "selected-mygeeks2" {
  name         = "myredgeeks2.es."
  vpc_id       = aws_vpc.red-geeks2.id
  private_zone = true
}

resource "aws_route53_record" "zona-entradas-mygeeks1" {
  for_each = var.entradas-mygeeks1-es
  zone_id  = data.aws_route53_zone.selected-mygeeks1.zone_id
  name     = each.value.name
  type     = each.value.type
  ttl      = each.value.ttl
  records  = [each.value.rrdatas]
}

resource "aws_route53_record" "zona-entradas-mygeeks2" {
  for_each = var.entradas-mygeeks2-es
  zone_id  = data.aws_route53_zone.selected-mygeeks2.zone_id
  name     = each.value.name
  type     = each.value.type
  ttl      = each.value.ttl
  records  = [each.value.rrdatas]
}
