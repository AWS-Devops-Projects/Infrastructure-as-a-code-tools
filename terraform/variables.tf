# ! ============ provider.tf ============

variable "aws_credentials_path" {
  type = string
}
variable "region" {
  type = string
}

# ! ============ ec2.tf ============
variable "instance_ami" {
  type = string
}

variable "instance_type" {
  type = string
}

variable "instance_name" {
  type = string
}

# ! ============ security_group.tf ============
variable "sg_name" {
  type = string
}
variable "app_port" {
  type = number
}

variable "key_name" {
  type = string
}
variable "public_key_path" {
  type = string
}


