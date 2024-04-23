terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.45.0"
    }
    mysql = {
      source  = "petoju/mysql"
      version = "3.0.54"
    }
  }
  #backend "s3" {
   # bucket = "datos-private-my-geeks2"
   # key    = "terraform/estado/terraform-state"
   # region = "eu-west-3"
  #}
}
