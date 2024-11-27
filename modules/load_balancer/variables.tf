variable "security_group_id" {
  description = "The security group ID to attach to the load balancer"
}

variable "public_subnet_ids" {
  description = "The public subnet IDs to attach to the load balancer"
}

variable "vpc_id" {
  description = "The VPC ID to attach to the load balancer"
}
