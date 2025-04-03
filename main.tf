


provider "aws" {
  region = "us-east-1"
}

terraform {
  backend "s3" {
    bucket = "sctp-ce9-tfstate"
    key    = "aalimsee-ce9-M3.2-github-workflow.tfstate" # Replace the value of key to <your>.tfstate, eg. terraform-ex-ec2-<NAME>.tfstate
    region = "us-east-1"
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.9" # Adjust as needed
    }
  }
  # required for TFLint to work properly
  # required_version = ">= 1.0" # Use the latest stable version or specify your desired version
}

data "aws_caller_identity" "current" {}

locals {
  name_prefix = split("/", data.aws_caller_identity.current.arn)[1]
  account_id  = data.aws_caller_identity.current.account_id
}

resource "aws_s3_bucket" "s3_tf" {
  bucket = "${local.name_prefix}-s3-tf-bkt-${local.account_id}"
}