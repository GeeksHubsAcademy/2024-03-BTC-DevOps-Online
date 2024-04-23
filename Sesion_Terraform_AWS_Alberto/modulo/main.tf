provider "aws" {
  region  = "eu-west-3"
  profile = "clave-ssh"
}

resource "aws_key_pair" "key" {
  key_name   = "access-key-am2"
  public_key = file("../keystore/id_rsa.pub")
}
