provider "aws" {
  region  = var.aws_region
  profile = "default"  #referencing profile configured voa AWS-CLI
}
