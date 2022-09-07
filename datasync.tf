resource "aws_datasync_task" "example" {
  provider                 = aws.destination
  destination_location_arn = aws_datasync_location_s3.destination_bucket_example.arn
  name                     = "this-source-to-destination-example"
  source_location_arn      = aws_datasync_location_s3.source_bucket_example.arn
  cloudwatch_log_group_arn = module.datasync_logging_example.cloudwatch_log_group_arn

  options {
    bytes_per_second  = -1
    posix_permissions = "NONE"
    uid               = "NONE"
    gid               = "NONE"
    verify_mode       = "NONE"
    log_level         = "BASIC"
  }

  schedule {
    schedule_expression = "cron(0 */8 * * ? *)" # every 8 hours
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
