###################
## DEPLOY REGION ##
###################
variable "region" {
  default = "eu-west-1"
}

########################
##INSTANCIA EC2 CONFIG##
########################
variable "instance_name" {
  description = "The tag Name for instance Bastion"
  default     = "bastion"
}
variable "instance_type" {
  default = "t3.small"
}

variable "instance-type" {
  description = "Instance Type from the bastion"
  default     = "t3.small"
}
variable "sg_ssh_access" {
  description = "IP whit ssh access the instance bastion"
  default     = "0.0.0.0/0"
}
variable "instance_count" {
  description = "Number of instances for deployment"
  default     = "1"
}
variable "monitoring" {
  description = "Apply monitoring detailed to 1 min"
  default     = "true"
}
variable "associate_public_ip_address" {
  description = "Attach public IP to the instance (true only if not apply Elastic IP)"
  default     = "false"
}
variable "source_dest_check" {
  description = "Configure in false only where the instance working with VPN service"
  default     = "false"
}
variable "ebs_root_size" {
  description = "Customize details about the root block device of the instance."
  default     = "20"
}

########
##TAGS##
########
variable "bastion_name" {
  description = "(Optional) Name of AWS keypair that will be created"
  default     = "bastion"
}
variable "env" {
  description = "Environment type"
  default     = "training"
}
variable "project" {
  description = "Project name"
  default     = "infraestructura"
}
variable "creator" {
  description = "Deploymente by"
  default     = "Reinaldo Leon"
}
variable "terraform" {
  description = "Terraform Template"
  default     = "true"
}
