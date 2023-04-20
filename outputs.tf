output "dns_hostnames_enabled" {
  description = "Indicates if instances launched in this VPC will have public DNS hostnames"
  value       = data.aws_vpc.this.enable_dns_hostnames
}

output "dns_support_enabled" {
  description = "Indicates if DNS support is enabled for this VPC"
  value       = data.aws_vpc.this.enable_dns_support
}

output "private_subnets" {
  description = "List of private subnets in this VPC"
  value       = sort([for subnet in data.aws_subnet.this : subnet.id if !subnet.map_public_ip_on_launch])
}

output "public_subnets" {
  description = "List of public subnets in this VPC"
  value       = sort([for subnet in data.aws_subnet.this : subnet.id if subnet.map_public_ip_on_launch])
}

output "vpc_arn" {
  description = "Arn of this VPC"
  value       = data.aws_vpc.this.arn
}

output "vpc_cidr_block" {
  description = "CIDR range for this VPC"
  value       = data.aws_vpc.this.cidr_block
}

output "vpc_cidr_blocks" {
  description = "All CIDR ranges for this VPC"
  value       = data.aws_vpc.this.cidr_block_associations[*].cidr_block
}

output "vpc_id" {
  description = "The ID of the VPC"
  value       = data.aws_vpc.this.id
}
