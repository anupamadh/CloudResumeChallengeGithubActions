#s3.tf

resource "aws_s3_bucket" "the-cloud-resume-challenge-terraform-anu" {
  bucket        = "the-cloud-resume-challenge-terraform-anu"
  force_destroy = true
  tags = {
    Name        = "The cloud resume challenge"
    Environment = "dev"
  }
}

# index page of the website
resource "aws_s3_object" "index-html" {
    bucket = aws_s3_bucket.the-cloud-resume-challenge-terraform-anu.id
    key = "index2.html"
    source = "${path.root}/../frontend/index2.html"
    content_type = "text/html"
}

# index page CSS
resource "aws_s3_object" "index-css" {
    bucket = aws_s3_bucket.the-cloud-resume-challenge-terraform-anu.id
    key = "style2.css"
    source = "${path.root}/../frontend/style2.css"
    content_type = "text/css"
}

# index page script
resource "aws_s3_object" "index-js" {
    bucket = aws_s3_bucket.the-cloud-resume-challenge-terraform-anu.id
    key = "index2.js"
    source = "${path.root}/../frontend/index2.js"
    content_type = "application/javascript"
}