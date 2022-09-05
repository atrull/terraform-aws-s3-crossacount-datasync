resource "aws_s3_bucket" "destination_example" {
  provider = aws.destination
  bucket   = "this-example-destination"
}

resource "aws_s3_bucket_versioning" "destination_example" {
  provider = aws.destination
  bucket   = aws_s3_bucket.destination_example.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_acl" "destination_example" {
  provider = aws.destination
  bucket   = aws_s3_bucket.destination_example.id
  acl      = "private"
}

resource "aws_s3_bucket_policy" "destination_example" {
  provider = aws.destination
  bucket   = aws_s3_bucket.destination_example.id
  policy   = <<POLICY
{
          "Version": "2008-10-17",
          "Statement": [
              {
                  "Sid": "bucket",
                  "Effect": "Allow",
                  "Principal": {
                      "AWS":  [
                        "${aws_iam_role.destination.arn}",
                        "${aws_iam_role.source.arn}"
                      ]
                  },
                  "Action": [
                    "s3:GetBucketLocation",
                    "s3:ListBucket",
                    "s3:ListBucketMultipartUploads",
                    "s3:AbortMultipartUpload",
                    "s3:DeleteObject",
                    "s3:GetObject",
                    "s3:ListMultipartUploadParts",
                    "s3:PutObjectTagging",
                    "s3:GetObjectTagging",
                    "s3:PutObject"
                  ],
                  "Resource": [
                    "${aws_s3_bucket.destination_example.arn}",
                    "${aws_s3_bucket.destination_example.arn}/*"
                  ]
              },
              {
                  "Sid": "terraform",
                  "Effect": "Allow",
                  "Principal": {
                      "AWS":  [
                        "${data.aws_caller_identity.destination.arn}",
                        "${data.aws_caller_identity.source.arn}"
                      ]
                  },
                  "Action": [
                    "s3:ListBucket"
                  ],
                  "Resource": [
                    "${aws_s3_bucket.destination_example.arn}",
                    "${aws_s3_bucket.destination_example.arn}/*"
                  ]
              }
          ]
}
POLICY
}
