terraform {
  backend "s3" {
    bucket         = "tfstatebuckeiis"
    key            = "terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
    dynamodb_table = "terraform-state-locks"
  }
}
