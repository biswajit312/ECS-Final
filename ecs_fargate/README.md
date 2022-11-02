# bax-infra
Terraform module for ECS Fargate Cluster.

Resources created by module -
ECS task definitions, ECS service, ECS cluster, Security groups for ECS service and load balancer, load balancer, target groups

Prerequisites
* Following values are required:
vpc_id, subnet_ids, aws region, application ports, security group ports

For example - 

AWS region 
aws_region = "us-east-1"

Bool for creating SG rules
create_sg_rules = true

vpc_id for ECS stack
vpc_id = "vpc-01f03e44c38e198e2"

subnet_ids for ECS stack
subnet_ids = [ "subnet-024a9fd91b8e4232e", "subnet-0f19a70a8cb00cfb2" ]


Usage -
1. Modify the parameter file (qual, dev etc) present under env_param folder.
2. Pass the parameter file to terraform commands terraform plan -var-file="env_var/qual.tfvars"


