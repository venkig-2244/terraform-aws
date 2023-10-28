variable "vpc_name" {
  type = string
  default = "my-vpc-01"
}

variable "aws_region" {
  type = string
  default = "us-east-1"
  description = "Region in which AWS resources will be created"
}

variable "instance_type" {
  type = string
  default = "t3.micro"
  description = "type of VM instace that will be created"
}

variable "instance_keypair" {
  type = string
  default = "terraform-key"
  description = "security keypair for VM login"
}

variable "instance_type_list" {
  type = list(string)
  description = "EC2 instnace types list"
  default = ["t3.micro", "t3.small", "t3.large"]
}

variable "instance_type_map" {
  description = "EC2 instance types map"
  type = map(string)
  default = {
    "dev" = "t3.micro",
    "qa" = "t3.small",
    "prod" = "t3.large"
  }
}
