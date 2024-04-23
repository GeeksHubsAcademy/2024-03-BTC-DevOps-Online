data "aws_caller_identity" "current" {}

output "account_id" {
  value = data.aws_caller_identity.current.account_id
}

output "public-ip-red-geeks1" {
  value = aws_eip.ip-publica-red-geeks1.public_ip
}

output "public-ip-red-geeks2" {
  value = aws_eip.ip-publica-red-geeks2.public_ip
}
