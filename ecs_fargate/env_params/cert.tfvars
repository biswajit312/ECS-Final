####################################################################################
#This file is used for value definition for specific environment e.g dev, prod, qual.
####################################################################################

// AWS region 
aws_region = "us-west-2"

// Bool for creating SG rules
create_sg_rules = true

// vpc_id for ECS stack
vpc_id = "vpc-06e661f56bbcdf151"

// subnet_ids for ECS stack
subnet_ids = [ "subnet-0af8d1d133f41752a", "subnet-0efb2186614002c1f" ]

// IP CIDR from which 80 & 443 will be allowed in loadbalancer SG
web_lb_cidr = ["0.0.0.0/0"]

// Tags for all the resources
tags = {
    Managed-by  = "Terraform"
    Env  = "dev"
  }

// Name of the ECS Cluster
ecs_cluster_name = "appmod-cluster"

// Set of names of one or more capacity providers to associate with the cluster.
capacity_providers = ["FARGATE"]

// Name of the default capacity provider
default_capacity_provider = "FARGATE"

// The number of tasks, at a minimum, to run on the specified capacity provider.
capacity_provider_base = 1

//The relative percentage of the total number of launched tasks that should use the specified capacity provider.
capacity_provider_weight = 100

// A unique name for your task definition.
task_definition_name = "app-mod-web"

// Docker networking mode to use for the containers in the task.
network_mode = "awsvpc"

// Number of cpu units used by the task.
task_definition_cpu = 1024

// Amount (in MiB) of memory used by the task
task_definition_memory = 2048

// Set of launch types required by the task. The valid values are EC2 and FARGATE
requires_compatibilities = [ "FARGATE" ]

// Configuration block for volumes that containers in your task may use.
volume_name = "app-mod"

// Name of the container
container_name = "app-mod-web"

// Name of the capacity provider
task_definition_image = "nginx"

// The number of CPU units set for the container.
// These are CPU and Memory combinations
  # cpu: 256 (.25 vCPU)  memory: 512 (0.5GB), 1024 (1GB), 2048 (2GB)
  # cpu: 512 (.5 vCPU)  memory: 1024 (1GB), 2048 (2GB), 3072 (3GB), 4096 (4GB)
  # cpu: 1024 (1 vCPU)  memory: 2048 (2GB), 3072 (3GB), 4096 (4GB), 5120 (5GB), 6144 (6GB), 7168 (7GB), 8192 (8GB)
  # cpu: 2048 (2 vCPU)  memory: Between 4096 (4GB) and 16384 (16GB) in increments of 1024 (1GB)
  # cpu: 4096 (4 vCPU)  memory: Between 8192 (8GB) and 30720 (30GB) in increments of 1024 (1GB)
container_cpu = 512

// The hard limit (in MiB) of memory set for the container.
container_memory = 512 

// If the essential parameter of a container is marked as true, and that container fails or stops for any reason, all other containers that are part of the task are stopped.
task_definition_essentail = true

// container_port
container_port = 80

// hostPort
hostPort = 80

// Name of the service
ecs_service_name =  "app-mod-service"

// Number of instances of the task definition.
desired_count = 2

// Launch type on which to run your service. The valid values are EC2, FARGATE, and EXTERNAL.
launch_type = "FARGATE"

// Scheduling strategy to use for the service. The valid values are REPLICA and DAEMON.
scheduling_strategy = "REPLICA"

// Seconds to ignore failing load balancer health checks on newly instantiated tasks to prevent premature shutdown
health_check_grace_period = 60

// Assign a public IP address to the ENI (Fargate launch type only).
assign_public_ip = true

// Upper limit (as a percentage of the service's desiredCount) of the number of running tasks that can be running in a service during a deployment.
deployment_maximum_percent = 200

// Lower limit (as a percentage of the service's desiredCount) of the number of running tasks that must remain running and healthy in a service during a deployment.
deployment_minimum_healthy_percent  = 100

// Name of the web service SG
web_service_sg_name = "app-mod-sg"

// Description of web service SG
web_service_sg_description = "SG created for ECS service"

// Web Service SG rule description
web_service_sg_rule_description = "Allow load Balancer traffic"

// loadbalancer name
load_balancer_name = "app-mod-lb"

// Loadbalancer mode if true, the LB will be internal.
internal = false

// The type of load balancer to create. Possible values are application, gateway, or network.
load_balancer_type = "application"

// If true, deletion of the load balancer will be disabled via the AWS API.
enable_deletion_protection = false

// Name of the target group
target_group_name = "appmod-target"

// Port on which targets receive traffic.
target_group_port = 80

// Protocol to use for routing traffic to the targets.
target_group_protocol = "HTTP"

// Type of target that you must specify when registering targets with this target group.
target_group_target_type = "ip"

// Destination for the health check request.
target_group_health_check_path = "/"

// Response codes to use when checking for a healthy responses from a target.
target_group_matcher = "200"

// Boolean to enable / disable stickiness.
health_check_enabled = true

// Protocol to use to connect with the target. Defaults to HTTP.
health_check_protocol = "HTTP"

// Amount of time, in seconds, during which no response means a failed health check.
health_check_timeout = 20

// health_check_interval
health_check_interval = 120

// Number of consecutive health checks 
health_check_healthy_threshold = 3

// Number of consecutive health check failures required before considering the target unhealthy.
health_check_unhealthy_threshold = 5

// Name of the web loadbalancer SG
web_lb_sg_name = "appmod-web-lb-sg"

// Description of web lb sg
web_lb_sg_description = "SG created for loadbalancer"

// Name of the capacity provider
web_lb_ingress_ports = [ "80","443" ]

// Protocol for SG Rules
web_lb_rules_protocol = "tcp"

