terraform {
  backend "s3" {
    region  = "us-east-1"
    bucket  = "infra-tfstate-angel-gonzalez"
    key     = "infra/ec2-angel-gonzalez/terraform.tfstate"
    encrypt = true
  }
}