resource "aws_s3_bucket" "webaapprojects" {
  bucket = "webaapprojects"

  tags = {
    Name        = "mysbucket"
    Environment = "Dev"
  }
}