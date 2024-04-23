############## FIREWALL GEEKS1 #############
reglasFW-geeks1-ingress = {
  ingress1 = {
    cidr        = ["0.0.0.0/0"]
    protocol    = "tcp"
    from_port   = "22"
    to_port     = "22"
    description = "ssh access"
  },
  ingress2 = {
    cidr        = ["0.0.0.0/0"]
    protocol    = "icmp"
    from_port   = "-1"
    to_port     = "-1"
    description = "icmp all permit"
  },
  ingress3 = {
    cidr        = ["0.0.0.0/0"]
    protocol    = "tcp"
    from_port   = "80"
    to_port     = "80"
    description = "http permitido"
  },
  ingress3 = {
    cidr        = ["0.0.0.0/0"]
    protocol    = "tcp"
    from_port   = "443"
    to_port     = "443"
    description = "https permitido"
  },
}

reglasFW-geeks1-egress = {
  egress1 = {
    cidr      = ["0.0.0.0/0"]
    protocol  = "-1"
    from_port = "0"
    to_port   = "0"
  }
}


############## FIREWALL GEEKS2 #############

reglasFW-geeks2-ingress = {
  ingress1 = {
    cidr        = ["0.0.0.0/0"]
    protocol    = "tcp"
    from_port   = "22"
    to_port     = "22"
    description = "ssh access"
  },
  ingress2 = {
    cidr        = ["0.0.0.0/0"]
    protocol    = "icmp"
    from_port   = "-1"
    to_port     = "-1"
    description = "icmp all permit"
  },
  ingress3 = {
    cidr        = ["0.0.0.0/0"]
    protocol    = "tcp"
    from_port   = "80"
    to_port     = "80"
    description = "http permit"
  },
}

reglasFW-geeks2-egress = {
  egress1 = {
    cidr      = ["0.0.0.0/0"]
    protocol  = "-1"
    from_port = "0"
    to_port   = "0"
  }
}

