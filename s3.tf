# Creating S3 bucket for remote state files
resource "aws_s3_bucket" "tflessons_state" {
  bucket = "tflessons-state"
  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_s3_bucket_versioning" "tflessons_state" {
  bucket = aws_s3_bucket.tflessons_state.id
  versioning_configuration {
    status = "Enabled"
  }
}
