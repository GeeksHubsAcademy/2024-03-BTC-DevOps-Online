###################
## DEPLOY REGION ##
###################
variable "region" {
  default = "eu-west-3"
}
##############
## KEY PAIR ##
##############
variable "key_list" {
  type    = list(any)
  default = ["security"]
}

##############
## ADD TAGS ##
##############
variable "project" {
  description = "Project name"
  default     = "dark"
}
variable "application" {
  description = "Application name"
  default     = "control"
}
variable "env" {
  description = "Environment type"
  default     = "dev"
}
variable "creator" {
  description = "Deploymente by"
  default     = "Master Devops"
}
variable "terraform" {
  description = "Terraform Template"
  default     = "True"
}
