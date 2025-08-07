terraform {
  backend "s3" {
    bucket = "testedtetetst"
    key    = "day-4/terraform.tfstate"
    region = "us-east-1"
  }
}
