provider "aws" {
  region  = "us-east-1"
  profile = "destination"
}

provider "aws" {
  region  = "us-east-1"
  alias   = "source"
  profile = "source"
}

provider "aws" {
  region  = "us-east-1"
  alias   = "destination"
  profile = "destination"
}

data "aws_caller_identity" "source" {
  provider = aws.source
}

data "aws_caller_identity" "destination" {
  provider = aws.destination
}
