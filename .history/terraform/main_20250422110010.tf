resource "aws_s3_bucket" "static_site" {
    bucket = var.bucket_name  
}

resource "aws_s3_bucket_website_configuration" "static_site_config" {
  bucket = aws_s3_bucket.static_site.id
}