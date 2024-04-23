############### VARIABLES GENERALES ############

paths-group1 = ["*.myredgeeks1.es"]
paths-group2 = ["*.myredgeeks2.es"]

healthy_threshold   = 4
unhealthy_threshold = 2
timeout             = 5
interval            = 10
target_protocol     = "HTTP"
target_port         = "80"

############## FIREWALL BALANCEADOR #############
reglasBal-geeks-ingress = {
  ingress1 = {
    cidr        = ["0.0.0.0/0"]
    protocol    = "tcp"
    from_port   = "80"
    to_port     = "80"
    description = ""
  },
}

reglasBal-geeks-egress = {
  egress1 = {
    cidr      = ["0.0.0.0/0"]
    protocol  = "-1"
    from_port = "0"
    to_port   = "0"
  }
}

