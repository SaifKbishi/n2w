locals {
  common_tags = {
    company      = var.company
    project      = "${var.company}-${var.project}"    
  }

  #s3_bucket_name = "globo-web-app-${random_integer.s3.result}"
}