variable "aws_region" {
  description = "Region in which AWS resources to be created"
  type        = string
  default     = "us-east-1"
}

variable "instance_type" {
  description = "Ec2 instance type"
  type        = string
  default     = "t2.micro"
}
variable "instance_type_list" {
  description = "Ec2 instance type list"
  type        = list(string)
  default     = ["t2.micro", "t3.small"]
}
variable "instance_type_map" {
  description = "Ec2 instance type map"
  type        = map(string)
  default = {
    "dev" : "t2.micro",
    "prod" : "t3.small"
  }
}

variable "instance_keypair" {
  description = "AWS ec2 key pair"
  default     = "ADMIN_KEYPAIR"
  type        = string
}
