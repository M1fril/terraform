resource "aws_s3_bucket" "my_terraform" {
  bucket = "remoute-tf-state-files"
  acl    = "private"

  tags = {

    Name = "remoute-terraform-state"

  }
}
