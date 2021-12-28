variable "availability_zones" {
  default     = []
  description = "Select subnets only in the given AZs"
  type        = set(string)
}

variable "vpc_name" {
  description = "The name of the VPC"
  type        = string
}
