#s3.tf

resource "aws_s3_bucket" "the-cloud-resume-challenge-terraform-anu-ghactions" {
  bucket        = "the-cloud-resume-challenge-terraform-anu-ghactions"
  force_destroy = true
  tags = {
    Name        = "The cloud resume challenge"
    Environment = "dev"
  }
}

# index page of the website
resource "aws_s3_object" "index-html" {
    bucket = aws_s3_bucket.the-cloud-resume-challenge-terraform-anu-ghactions.id
    key = "index2.html"
    source = "${path.root}/../frontend/index2.html"
    etag = filemd5("${path.root}/../frontend/index2.html")
    content_type = "text/html"
}

# index page CSS
resource "aws_s3_object" "index-css" {
    bucket = aws_s3_bucket.the-cloud-resume-challenge-terraform-anu-ghactions.id
    key = "style2.css"
    source = "${path.root}/../frontend/style2.css"
    etag = filemd5("${path.root}/../frontend/style2.css")
    content_type = "text/css"
}

# index page script
resource "aws_s3_object" "index-js" {
    bucket = aws_s3_bucket.the-cloud-resume-challenge-terraform-anu-ghactions.id
    key = "index2.js"
    source = "${path.root}/../frontend/index2.js"
    etag         = filemd5("${path.root}/../frontend/index2.js")
    content_type = "application/javascript"
}

# Invalidate the CF cache when S3 website home page is updated
resource "null_resource" "invalidate_cf_cache_index" {
  provisioner "local-exec" {
    command = "aws cloudfront create-invalidation --distribution-id ${var.cf_id} --paths '/index2.html'"
  }
  triggers = {
    website_version_changed = aws_s3_object.index-html.version_id
  }
}

# Invalidate the CF cache when S3 script is updated
resource "null_resource" "invalidate_cf_cache_script" {
  provisioner "local-exec" {
    command = "aws cloudfront create-invalidation --distribution-id ${var.cf_id} --paths '/index2.js'"
  }
  triggers = {
    website_version_changed = aws_s3_object.index-js.version_id
  }
}

# Invalidate the CF cache when S3 css is updated
resource "null_resource" "invalidate_cf_cache_css" {
  provisioner "local-exec" {
    command = "aws cloudfront create-invalidation --distribution-id ${var.cf_id} --paths '/style2.css'"
  }
  triggers = {
    website_version_changed = aws_s3_object.index-css.version_id
  }
}
