#STORE STATE FILE IN S3 BUCKET
terraform {
  backend "s3" {
    bucket = "devsecops-infra-state-files"
    region = "us-east-1"
    key = "devsecops-infra/terraform.tfstate"
    shared_credentials_file = var.aws_credentials_path
  }
}
