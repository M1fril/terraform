provider "aws" {
  region = "eu-west-1"

}

terraform {
  backend "s3" {
    bucket = "remoute-tf-state-files"
    key    = "sub_modules.tf"
    region = "eu-west-1"
  }
}
