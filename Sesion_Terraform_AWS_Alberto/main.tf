provider "aws" {
  region  = "eu-west-3"
  profile = "clave-ssh"
}

resource "aws_key_pair" "key" {
  key_name   = "access-key-am"
  public_key = file("../keystore/id_rsa.pub")
}
