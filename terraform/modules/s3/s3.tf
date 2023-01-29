resource "aws_s3_bucket" "json_bucket" {
  bucket        = "json_bucket"
  acl           = "private"
  force_destroy = true
}