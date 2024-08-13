# store the terraform state file in s3
terraform {
  backend "s3" { 
    bucket    = "terraform-remote-state-010526261082"
    key       =  "ssc-prod.tfstate"
    region    =  "ap-southeast-2"
   # profile   =  "terraform-user"
  }
}