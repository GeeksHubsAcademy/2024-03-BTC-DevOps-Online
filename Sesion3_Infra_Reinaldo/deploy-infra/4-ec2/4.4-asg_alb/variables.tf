############
## REGION ##
############
variable "azs" {
  default = ["eu-west-3a", "eu-west-3b"]
  type    = list(any)
}
variable "region" {
  default = "eu-west-3"
}
##################
## ASG CAPACITY ##
##################
variable "max_size" {
  default = "1"
}
variable "min_size" {
  default = "1"
}
variable "desired_capacity" {
  default = "1"
}
variable "health_check_grace_period" {
  default = "300"
}
variable "instance_type" {
  default = "t3.small"
}
variable "app_name" {
  description = "The name for key prestashop instance"
  default     = "wordpress"
}

##########
## TAGS ##
##########
variable "asg_name" {
  default = "ASG-Wordpress"
  type    = string
}

variable "lc_name" {
  default = "LC-wordpress"
  type    = string
}

variable "env" {
  default = "training"
}
variable "project" {
  default = "grupo3"
}
variable "creator" {
  default = "grupo3"
}
variable "terraform" {
  default = "true"
}
