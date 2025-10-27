# terraform {
#   backend "s3" {
#     bucket         = "ladsoftterarforms3"
#     key            = "prod/terraform.tfstate"
#     region         = "ap-south-1"
#     encrypt        = true
#     profile = "default"
#   }
# }


terraform {
  backend "s3" {
    bucket               = "ladsoftawss3bucket"
    region               = "ap-south-1"
    encrypt              = true

    # This 'key' is the filename used inside each workspace folder
    key                  = "terraform.tfstate"

    # Each workspace gets its own folder: state/<workspace>/terraform.tfstate
    workspace_key_prefix = "state"

    # Optional: if you want Terraform to use a specific AWS CLI profile
    # profile = "s3"
  }
}