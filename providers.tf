terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.64.0"
    }
  }

  backend "s3" {
    bucket  = "me.state-bucket-tf"
    region  = "us-east-1"
    key     = "terraform.tfstate"
    encrypt = true

    profile = "pj-aws-sso"
  }
}

provider "aws" {
  profile = "pj-aws-sso"
}

resource "aws_s3_bucket" "terraform_state" {
  bucket = var.state_bucket

  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_s3_bucket_versioning" "terraform_state" {
  bucket = aws_s3_bucket.terraform_state.bucket

  versioning_configuration {
    status = "Enabled"
  }

  depends_on = [
    aws_s3_bucket.terraform_state
  ]
}