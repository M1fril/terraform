data "terraform_remote_state" "networking" {
  backend = "s3"
  config = {
    bucket = "remoute-tf-state-files"
    key    = "networking.tf"
    region = "eu-west-1"
  }
}
