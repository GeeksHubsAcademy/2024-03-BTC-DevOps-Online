resource "aws_s3_bucket" "datos-private-my-geeks" {
  bucket = "datos-private-my-geeks2"

  versioning {
    enabled = true
  }

  tags = {
    Name = "Datos-Geeks"
    Env  = "Pro"
  }
}

