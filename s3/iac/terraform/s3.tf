resource "aws_s3_bucket" "bucket" {
  bucket = "my-tf-test-bucket-az-vlev"

  tags = {
    Name        = "my-tf-test-bucket-az-vlev"
    Environment = "Dev"
  }
}
