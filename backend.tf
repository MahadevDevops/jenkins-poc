terraform {
  backend "s3" {
    bucket = "sapient-terraform-state-file"
    key    = "state-file"
    region = "us-west-1"
  }
}
