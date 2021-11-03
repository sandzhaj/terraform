variable "instance_type" {
  description = "Enter Instance Type"
  type        = string
  default     = "t3.small"
}


variable "allow_ports" {
  description = "List of Ports to open for server"
  type        = list
  default     = ["80", "443", "22", "8080"]
}

variable "enable_detailed_monitoring" {
  type    = bool
  default = false
}


variable "common_tags" {
  description = "Common Tags"
  type        = map
  default = {
    Owner       = "Mark"
    Project     = "Terraform"
    Environment = "development"
  }
}
