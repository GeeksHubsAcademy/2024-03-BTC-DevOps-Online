resource "aws_s3_bucket" "bucket" {
  bucket = "terraform-${var.project}-${var.env}"
  acl    = "private"

  versioning {
    enabled = true
  }

  tags = {
    Name        = "terraform-${var.project}-${var.env}"
    Environment = var.env
    Creator     = var.creator
    Terraform   = var.terraform
  }
}

##CREATE DYNAMODB TABLE PARA BLOQUEAR EL ESTADO
resource "aws_dynamodb_table" "terraform_state_locking" {
  name           = "terraform_state_locking-${var.project}-${var.env}"
  hash_key       = "LockID"
  read_capacity  = 5
  write_capacity = 5

  point_in_time_recovery {
    enabled = true
  }

  server_side_encryption {
    enabled = true
  }

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    Name        = "terraform-${var.project}-${var.env}"
    Environment = var.env
    Creator     = var.creator
    Terraform   = var.terraform
  }
}
