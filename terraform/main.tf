provider "aws" {
  region = "ap-south-1"
}

resource "aws_s3_bucket" "site" {
  bucket = "poorna-cloud-portfolio-7181"
}

resource "aws_s3_bucket_website_configuration" "site" {
  bucket = aws_s3_bucket.site.id

  index_document {
    suffix = "index.html"
  }
}

resource "aws_s3_bucket_public_access_block" "public_access" {
  bucket = aws_s3_bucket.site.id

  block_public_acls   = false
  block_public_policy = false
}

resource "aws_s3_bucket_policy" "public_policy" {
  bucket = aws_s3_bucket.site.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = "*"
      Action = ["s3:GetObject"]
      Resource = "${aws_s3_bucket.site.arn}/*"
    }]
  })
}
