resource "aws_s3_bucket" "outline-s3-bucket-20230904" {
  bucket = "outline-s3-bucket-20230904"

  tags = {
    Name = "outline-s3-bucket-20230904"
  }
}

resource "aws_s3_access_point" "outline-s3-access-point" {
  bucket = aws_s3_bucket.outline-s3-bucket-20230904.id
  name   = "outline-s3-access-point"
}