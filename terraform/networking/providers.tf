provider "aws" {
  region = "eu-west-1"

}

terraform {
  backend "s3" {
    bucket = "remoute-tf-state-files"
    key    = "networking.tf"
    region = "eu-west-1"
  }
}
