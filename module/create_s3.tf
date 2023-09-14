resource "aws_s3_bucket" "outline-s3-bucket-astroicers" {
  bucket = "outline-s3-bucket-astroicers"
  tags = {
    Name = "outline-s3-bucket-astroicers"
  }
}

resource "aws_s3_access_point" "outline-s3-access-point" {
  bucket = aws_s3_bucket.outline-s3-bucket-astroicers.id
  name   = "outline-s3-access-point"
}
