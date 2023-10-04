resource "aws_s3_bucket" "outline-s3-bucket" {
  bucket = var.s3_name
  tags = {
    Name = var.s3_name
  }
}

resource "aws_s3_access_point" "outline-s3-access-point" {
  bucket = aws_s3_bucket.outline-s3-bucket.id
  name   = "outline-s3-access-point"
}
