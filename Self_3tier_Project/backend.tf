terraform {
  backend "s3" {
    bucket = "terraformprojectbucket"
    key    = "demo/terraform.tfstate"
    region = "us-east-1"
  }
}
