#####################
## VARIABLE GLOBAL ##
#####################
variable "region" {
  default = "eu-west-1"
}

##############
## ADD TAGS ##
##############
variable "project" {
  default = "devops"
}
variable "env" {
  default = "dev"
}
variable "creator" {
  default = "DevOps Team"
}
variable "application" {
  default = "base"
}
variable "terraform" {
  default = "True"
}
