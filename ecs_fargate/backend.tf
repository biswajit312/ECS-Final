
# terraform {
#   backend "s3" {
#     bucket = "appmodernization-terraform-backend"
#     key    = "ecs_fargate/terraform.tfstate"
#     region = "us-west-2"
#   }
# }




#######################  Terraform Cloud Backend
# terraform {
#   backend "remote" {
#     hostname     = "app.terraform.io"
#     organization = "Bax-Infra"

#     workspaces {
#       name = "bax-infra"
#     }
#   }
# }


#######################  S3 Backend

# terraform {
#   backend "s3" {
#     #This will allow you to download and view your state file.
#     acl     = "bucket-owner-full-control"
#     #---------------------------
#     # NEVER CHANGE THESE VALUES
#     #---------------------------
#     #This is the bucket where to store your state file.
#    # bucket  = var.bucket_state_file
#     #This ensures the state file is stored encrypted at rest in S3.
#     encrypt = true
#     #This is the region of your S3 Bucket.
#     region  = "us-east-1"
#     #---------------------------
#     # Configurable Options
#     #---------------------------
#     #This will be the state file's file name.
#    # key     = var.db_cluster_instance_name
#     #This will be used as a folder in which to store your state file.
#     workspace_key_prefix = "example-rds"
#   }
# }