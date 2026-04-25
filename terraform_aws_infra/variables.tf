# AWS keypair
variable "ssh_keypair" {
  type        = string
  default     = "ann-web-serve"
  description = "name of AWS SSH key-pair"
} 

# AWS keypair
variable "aws_credentials_path" {
  type        = string
  default     = "~/.aws/credentials3"
  description = "path to AWS access credentials"
} 
