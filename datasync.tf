resource "aws_datasync_task" "example" {
  provider                 = aws.destination
  destination_location_arn = aws_datasync_location_s3.destination_bucket_example.arn
  name                     = "this-source-to-destination-example"
  source_location_arn      = aws_datasync_location_s3.source_bucket_example.arn

  options {
    bytes_per_second  = -1
    posix_permissions = "NONE"
    uid               = "NONE"
    gid               = "NONE"
  }
}

resource "aws_datasync_location_s3" "destination_bucket_example" {
  provider      = aws.destination
  s3_bucket_arn = aws_s3_bucket.destination_example.arn
  subdirectory  = "/"

  s3_config {
    bucket_access_role_arn = aws_iam_role.destination.arn
  }
}

resource "aws_datasync_location_s3" "source_bucket_example" {
  provider      = aws.destination
  s3_bucket_arn = aws_s3_bucket.source_example.arn
  subdirectory  = "/"

  s3_config {
    bucket_access_role_arn = aws_iam_role.destination.arn
  }
}
