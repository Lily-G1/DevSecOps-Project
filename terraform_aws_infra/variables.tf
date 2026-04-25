# AWS keypair
variable "ssh_keypair" {
  type        = string
  default     = "ann-web-server"
  description = "name of AWS SSH key-pair"
} 
