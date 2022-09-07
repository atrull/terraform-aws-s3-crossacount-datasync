module "datasync_logging_example" {
  # provider = aws.destination not sure this will work
  source  = "terraform-aws-modules/cloudwatch/aws//modules/log-group"
  version = "~> 2.0"

  name              = "datasync-logging-example"
  retention_in_days = 30
}

data "aws_iam_policy_document" "datasync-log-publishing-policy" {
  statement {
    actions = [
      "logs:CreateLogStream",
      "logs:PutLogEvents",
      "logs:PutLogEventsBatch"
    ]

    resources = ["arn:aws:logs:*"]

    principals {
      identifiers = ["datasync.amazonaws.com"]
      type        = "Service"
    }
  }
}

resource "aws_cloudwatch_log_resource_policy" "datasync-log-publishing-policy" {
  provider        = aws.destination
  policy_document = data.aws_iam_policy_document.datasync-log-publishing-policy.json
  policy_name     = "datasync-log-publishing-policy"
}
