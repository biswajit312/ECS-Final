variable "create_sg_rules" {
  description = "Bool for creating SG rules"
  type        = bool
}

variable "vpc_id" {
  description = "vpc id"
  type        = string
}

variable "aws_region" {
  description = "aws region"
  type        = string
}

variable "subnet_ids" {
  description = "Subnets associated with the task or service."
  type        = list(string)
}

variable "web_lb_cidr" {
  description = "Subnets associated with the task or service."
  type        = list(string)
}


variable "tags" {
  description = "Tags for all the resources"
  type        = map(string)
}


// aws_ecs_cluster variables
variable "ecs_cluster_name" {
  description = "Name of the capacity provider"
  type        = string
}


// aws_ecs_cluster_capacity_providers variables

variable "capacity_providers" {
  description = "Set of names of one or more capacity providers to associate with the cluster."
  type        = list(string)
}

variable "default_capacity_provider" {
  description = "Name of the capacity provider"
  type        = string
}

variable "capacity_provider_base" {
  description = "The number of tasks, at a minimum, to run on the specified capacity provider."
  type        = number
}

variable "capacity_provider_weight" {
  description = "The relative percentage of the total number of launched tasks that should use the specified capacity provider."
  type        = number
}


// aws_ecs_task_definition Variables

variable "task_definition_name" {
  description = "A unique name for your task definition."
  type        = string
}


variable "network_mode" {
  description = "Docker networking mode to use for the containers in the task."
  type        = string
}


variable "task_definition_cpu" {
  description = "Number of cpu units used by the task."
  type        = number
}

variable "task_definition_memory" {
  description = "Amount (in MiB) of memory used by the task"
  type        = number
}

variable "requires_compatibilities" {
  description = "Set of launch types required by the task. The valid values are EC2 and FARGATE"
  type        = list(string)
}


variable "volume_name" {
  description = "Configuration block for volumes that containers in your task may use."
  type        = string
}

variable "container_name" {
  description = "Name of the container"
  type        = string
}


variable "task_definition_image" {
  description = "Name of the capacity provider"
  type        = string
}


variable "container_cpu" {
  description = "The number of CPU units set for the container."
  type        = number
}


variable "container_memory" {
  description = "The hard limit (in MiB) of memory set for the container."
  type        = number
}

variable "task_definition_essentail" {
  description = "If the essential parameter of a container is marked as true, and that container fails or stops for any reason, all other containers that are part of the task are stopped."
  type        = bool
}


variable "container_port" {
  description = "Container Port"
  type        = number
}


variable "hostPort" {
  description = "Host Port"
  type        = number
}

// aws_ecs_service variables

variable "ecs_service_name" {
  description = "Name of the service"
  type        = string
}

variable "desired_count" {
  description = "Number of instances of the task definition."
  type        = number
}

variable "launch_type" {
  description = "Launch type on which to run your service. The valid values are EC2, FARGATE, and EXTERNAL."
  type        = string
}


variable "scheduling_strategy" {
  description = "Scheduling strategy to use for the service. The valid values are REPLICA and DAEMON."
  type        = string
}

variable "health_check_grace_period" {
  description = "econds to ignore failing load balancer health checks on newly instantiated tasks to prevent premature shutdown"
  type        = number
}


variable "assign_public_ip" {
  description = "Assign a public IP address to the ENI (Fargate launch type only)."
  type        = bool
}


variable "deployment_maximum_percent" {
  description = "Upper limit (as a percentage of the service's desiredCount) of the number of running tasks that can be running in a service during a deployment."
  type        = number
}


variable "deployment_minimum_healthy_percent" {
  description = "Lower limit (as a percentage of the service's desiredCount) of the number of running tasks that must remain running and healthy in a service during a deployment."
  type        = number
}

// aws_security_group variables

variable "web_service_sg_name" {
  description = "Name of the web service SG"
  type        = string
}

variable "web_service_sg_description" {
  description = "Description of web service SG"
  type        = string
}


variable "web_service_sg_rule_description" {
  description = "SG rule description"
  type        = string
}


// aws_lb variables

variable "load_balancer_name" {
  description = "loadbalancer namer"
  type        = string
}


variable "internal" {
  description = "If true, the LB will be internal."
  type        = bool
}

variable "load_balancer_type" {
  description = "The type of load balancer to create. Possible values are application, gateway, or network."
  type        = string
}

variable "enable_deletion_protection" {
  description = "If true, deletion of the load balancer will be disabled via the AWS API."
  type        = bool
}

// aws_lb_target_group variables

variable "blue_target_group_name" {
  description = "Name of the target group"
  type        = string
}

variable "blue_target_group_port" {
  description = "Port on which targets receive traffic."
  type        = number
}


variable "target_group_protocol" {
  description = "Protocol to use for routing traffic to the targets."
  type        = string
}


variable "target_group_target_type" {
  description = "Type of target that you must specify when registering targets with this target group."
  type        = string
}


variable "target_group_health_check_path" {
  description = "destination for the health check request."
  type        = string
}


variable "target_group_matcher" {
  description = "Response codes to use when checking for a healthy responses from a target."
  type        = string
}


variable "health_check_enabled" {
  description = "boolean to enable / disable stickiness."
  type        = bool
}


variable "health_check_protocol" {
  description = "Protocol to use to connect with the target. Defaults to HTTP."
  type        = string
}


variable "health_check_timeout" {
  description = "Amount of time, in seconds, during which no response means a failed health check."
  type        = number
}

variable "health_check_interval" {
  description = "Health check interval"
  type        = number
}



variable "health_check_healthy_threshold" {
  description = " Number of consecutive health checks "
  type        = number
}


variable "health_check_unhealthy_threshold" {
  description = "Number of consecutive health check failures required before considering the target unhealthy."
  type        = number
}


// Green target group protocol

variable "green_target_group_name" {
  description = "Name of the target group"
  type        = string
}

variable "green_target_group_port" {
  description = "Port on which targets receive traffic."
  type        = number
}

// Listeners

variable "green_listener_port" {
  description = "Port on which green listener receive traffic."
  type        = number
}

variable "blue_listener_port" {
  description = "Port on which blue listener receive traffic."
  type        = number
}
// aws_security_group  variables

variable "web_lb_sg_name" {
  description = "Name of the web loadbalancer SG"
  type        = string
}


variable "web_lb_sg_description" {
  description = "Description of web lb sg"
  type        = string
}


variable "web_lb_ingress_ports" {
  description = "Name of the capacity provider"
  type        = list(string)
}

variable "web_lb_rules_protocol" {
  description = "Protocol for SG Rules"
  type        = string
}


variable "web_service_sg_port" {
  description = "Ingress port number for ECS service SG"
  type        = number
}


