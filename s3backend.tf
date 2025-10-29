terraform {
  backend "s3" {
    bucket               = "ladsoftterarforms3"
    region               = "ap-south-1"
    #encrypt              = true
    key                  = "prod/terraform.tfstate"
  }
}


