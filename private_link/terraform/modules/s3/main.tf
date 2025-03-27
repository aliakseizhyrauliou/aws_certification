resource "aws_s3_bucket" "s3" {
  bucket = format("s3-%s", var.project_name)
}

resource "aws_s3_bucket_ownership_controls" "ownersip_control" {
  bucket = aws_s3_bucket.s3.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_public_access_block" "block_public" {
  bucket = aws_s3_bucket.s3.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_acl" "acl" {
  depends_on = [
    aws_s3_bucket_ownership_controls.ownersip_control,
    aws_s3_bucket_public_access_block.block_public,
  ]

  bucket = aws_s3_bucket.s3.id
  acl    = "private"
}