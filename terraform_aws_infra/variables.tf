# AWS keypair
variable "ssh_keypair" {
  type        = string
  default     = "default"
  description = "name of AWS SSH key-pair"
} 
