resource "aws_vpc_peering_connection" "peering-red-geeks2-to-geeks1" {
  peer_owner_id = "519393677523"
  peer_vpc_id   = var.vpc-id-geeks1
  vpc_id        = aws_vpc.red-geeks2.id
  peer_region   = var.region
}

resource "aws_vpc_peering_connection" "peering-red-geeks1-to-geeks2" {
  peer_owner_id = "519393677523"
  peer_vpc_id   = var.vpc-id-geeks2
  vpc_id        = aws_vpc.red-geeks1.id
  peer_region   = var.region
}
