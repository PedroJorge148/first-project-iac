module "s3" {
  source         = "./modules/s3"
  s3_bucket_name = "bucket-terraform-iac"

  s3_tags = {
    iac = true
  }
}

module "cloudfront" {
  source             = "./modules/cloudfront"
  origin_id          = module.s3.bucket_id
  bucket_domain_name = module.s3.bucket_domain_name
  cdn_price_class    = "PriceClass_200"
  cdn_tags = {
    iac = true
  }

  depends_on = [
    module.s3
  ]
}

# module "sqs" {
#   source     = "terraform-aws-modules/sqs/aws"
#   name       = "sqs-terraform-iac"
#   create_dlq = true

#   tags = {
#     iac = true
#   }
# }