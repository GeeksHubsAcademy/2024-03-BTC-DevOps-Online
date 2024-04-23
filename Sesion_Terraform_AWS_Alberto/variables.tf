############## GERERALES #################

variable "green_enabled" {
  default = true
  type    = bool
}
variable "region" {}
variable "ami-rocky-linux" {}

#variable "ami-rocky-linux" {
#  type    = string
#  default = "el valor"
#}

########### FIN GENERALES ################





################## VPC ###################

variable "vpc-id-geeks1" {}
variable "vpc-id-geeks2" {}

variable "ipcidr-redgeeks1" {}
variable "ipcidr-redgeeks2" {}
variable "subred-publica-geeks1-cidr" {}
variable "subred-publica-geeks2-cidr" {}

variable "subredes-geeks1" {
  description = "subredes de VPCs"
  type = map(object({
    red  = string
    cidr = string
    zone = string
    tag  = string
  }))
}

variable "subredes-geeks2" {
  description = "subredes de VPCs"
  type = map(object({
    red  = string
    cidr = string
    zone = string
    tag  = string
  }))
}


################## FIN VPC ###################


################### FIREWALL #################

variable "reglasFW-geeks1-ingress" {
  description = "red geek1 reglas ingress"
  type = map(object({
    cidr        = list(string)
    protocol    = string
    from_port   = string
    to_port     = string
    description = string
  }))
}

variable "reglasFW-geeks1-egress" {
  description = "red geek1 reglas egress"
  type = map(object({
    cidr      = list(string)
    protocol  = string
    from_port = string
    to_port   = string
  }))
}

variable "reglasFW-geeks2-ingress" {
  description = "red geek2 reglas ingress"
  type = map(object({
    cidr        = list(string)
    protocol    = string
    from_port   = string
    to_port     = string
    description = string
  }))
}

variable "reglasFW-geeks2-egress" {
  description = "red geek2 reglas egress"
  type = map(object({
    cidr      = list(string)
    protocol  = string
    from_port = string
    to_port   = string
  }))
}

############## FIN FIREWALL ##################


############## DNS ####################
variable "dns-domains" {}
variable "ns-zone-domains-ttl" {}
variable "entradas-mygeeks1-es" {
  description = "Entradas dns"
  type = map(object({
    managed_zone = string
    name         = string
    type         = string
    ttl          = string
    rrdatas      = string
  }))
}
variable "entradas-mygeeks2-es" {
  description = "Entradas dns"
  type = map(object({
    managed_zone = string
    name         = string
    type         = string
    ttl          = string
    rrdatas      = string
  }))
}


##################### VARIABLES EKS ########################

variable "eks-redes-geeks" {}
variable "service-cidr-eks-geeks" {}
variable "eks-subredes-privada-geeks" {}
variable "eks-subredes-publica-geeks" {}
variable "eks-zone-geeks" {}
variable "count-eks-zones-geeks" {}

variable "eks-cidr-access-geeks" {}
variable "desire-size-eks-geeks-ingress" {}
variable "max-size-eks-geeks-ingress" {}
variable "min-size-eks-geeks-ingress" {}
variable "disk-size-eks-geeks" {}
variable "type-eks-geeks-ingress" {}
variable "eks-version-geeks" {}

variable "desire-size-eks-geeks-nodes" {}
variable "max-size-eks-geeks-nodes" {}
variable "min-size-eks-geeks-nodes" {}
variable "type-eks-geeks-nodes" {}

################ BALANCEADOR #####################
variable "reglasBal-geeks-ingress" {
  description = "Balandeador reglas ingress"
  type = map(object({
    cidr        = list(string)
    protocol    = string
    from_port   = string
    to_port     = string
    description = string
  }))
}

variable "reglasBal-geeks-egress" {
  description = "Balanceador reglas egress"
  type = map(object({
    cidr      = list(string)
    protocol  = string
    from_port = string
    to_port   = string
  }))
}

variable "subred-publica2-geeks1-cidr" {}
variable "target_protocol" {}
variable "target_port" {}
variable "healthy_threshold" {}
variable "unhealthy_threshold" {}
variable "timeout" {}
variable "interval" {}

variable "paths-group1" {
  type = list(string)
}

variable "paths-group2" {
  type = list(string)
}


###################### BD VARIABLES ###################

variable "engine" {}
variable "engine_version" {}
variable "zones_cluster" {}
variable "database_cluster_name" {}
variable "master_username_cluster" {}
variable "master_password_cluster" {}
variable "backup_retention_period" {}
variable "preferred_backup_window" {}
variable "db_cluster_instance_class" {}
variable "allocated_storage_bd" {}
