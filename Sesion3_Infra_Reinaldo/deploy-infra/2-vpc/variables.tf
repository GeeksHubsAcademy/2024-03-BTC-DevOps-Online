###################
## DEPLOY REGION ##
###################
variable "region" {
  default = "eu-west-3"
}

#######################
## VPC CONFIGURATION ##
#######################
variable "vpc_cidr" {
  default = "10.0.0.0/16"
  type    = string
}
variable "azs" {
  default = ["eu-west-3a", "eu-west-3b", "eu-west-3c"]
  type    = list(any)
}
variable "vpc_subnet_cidr" {
  default = [
    "10.0.0.0/24",
    "10.0.1.0/24",
    "10.0.2.0/24",
    "10.0.3.0/24",
    "10.0.4.0/24",
    "10.0.5.0/24",
    "10.0.6.0/24",
    "10.0.7.0/24",
    "10.0.8.0/24",
  ]
  type = list(any)
}
###########################
## VPC DNS CONFIGURATION ##
###########################
variable "enable_dns_hostnames" {
  description = "Support DNS Host Name"
  default     = "true"
}
variable "enable_dns_support" {
  description = "Support DNS"
  default     = "true"
}

###############################
## NAT GATEWAY CONFIGURATION ##
###############################
variable "enable_nat_gateway" {
  description = "Use NAT gateway from Private RT"
  default     = "true"
}
variable "single_nat_gateway" {
  description = "Configure NAT gateway only from Public AZA"
  default     = "true"
}
variable "one_nat_gateway_per_az" {
  description = "Configure NAT gateway from all the Public AZs (Required single_nat_gateway=false)"
  default     = "false"
}

####################################
# PUBLIC ACCESS TO RDS INSTANCES ###
####################################

variable "public_bbdd" {
  description = "Change Database Subnet to Public Subnet"
  default     = "false"
}

######################################
## ENABLE VPN GATEWAY CONFIGURATION ##
######################################

variable "enable_vpn_gateway" {
  description = "Enable configuration VPN Gateway"
  default     = "false"
}

###########
## TAGS  ##
###########
variable "project" {
  default = "infraestructura"
}
variable "env" {
  default = "stg"
}
variable "creator" {
  default = "Group-2"
}
variable "terraform" {
  default = "true"
}
