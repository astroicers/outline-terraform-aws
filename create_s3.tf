resource "aws_s3_bucket" "outline-s3-bucket-20230502" {
  bucket = "outline-s3-bucket-20230502"

  tags = {
    Name = "outline-s3-bucket-20230502"
  }
}

resource "aws_s3_access_point" "outline-s3-access-point" {
  bucket = aws_s3_bucket.outline-s3-bucket-20230502.id
  name   = "outline-s3-access-point"
}