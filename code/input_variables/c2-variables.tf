variable "aws_region" {
  type = string
  default = "us-east-1"
  description = "Region in which AWS resources will be created"
}

variable "instance_type" {
  type = string
  default = "t2.micro"
  description = "type of VM instace that will be created"
}

variable "instance_keypair" {
  type = string
  default = "terraform-key"
  description = "security keypair for VM login"
}
