provider "aws" {
  region = "eu-west-1"

}

terraform {
  backend "s3" {
    bucket = "remoute-tf-state-files"
    key    = "application.tf"
    region = "eu-west-1"
  }
}
