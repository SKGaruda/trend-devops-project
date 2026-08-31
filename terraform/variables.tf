variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "ap-south-1"
}

variable "project_name" {
  description = "Project name"
  type        = string
  default     = "trend-devops"
}

variable "instance_type" {
  description = "Jenkins EC2 instance type"
  type        = string
  default     = "t3.medium"
}

variable "allowed_ssh_ip" {
  description = "Public IP allowed for SSH access"
  type        = string
}