terraform {
   backend "s3" {
     bucket = "udacity-tf-drw-west"
     key    = "terraform/terraform.tfstate"
     region = "us-west-1"
   }
 }

 #provider "aws" {
 #  region = "us-east-2"
   #profile = "default"
   
 #  default_tags {
 #    tags = local.tags
 #  }
 #}

 provider "aws" {
  alias  = "usw1"
  region = "us-west-1"
    
  default_tags {
     tags = local.tags
   }
}
