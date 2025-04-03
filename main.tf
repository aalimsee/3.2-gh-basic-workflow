


provider "aws" {
  region = "us-east-1"
}

terraform {
  backend "s3" {
    bucket = "sctp-ce9-tfstate"
    key    = "aalimsee-ce9-M3.2-github-workflow.tfstate" # Replace the value of key to <your>.tfstate
    region = "us-east-1"
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.9" # Adjust as needed
    }
  }
  required_version = ">= 1.0" # Use the latest stable version or specify your desired version
}

data "aws_caller_identity" "current" {}

locals {
  name_prefix = split("/", data.aws_caller_identity.current.arn)[1]
  account_id  = data.aws_caller_identity.current.account_id
}

resource "aws_s3_bucket" "example_dev" {
  bucket = "${local.name_prefix}-s3-tf-bkt-${local.account_id}"
  #checkov:skip=CKV_AWS_18:Ensure the S3 bucket has access logging enabled
}

resource "aws_s3_bucket_lifecycle_configuration" "example_dev_lifecycle" {
  bucket = aws_s3_bucket.example_dev.id

  rule {
    id     = "ManageLifecycleAndDelete"
    status = "Enabled"

    transition {
      days          = 30
      storage_class = "STANDARD_IA"
    }

    expiration {
      days = 90
    }
  }
}

