// ECS Resource File

resource "aws_ecs_cluster" "ecs_cluster" {
  name = var.ecs_cluster_name
}


resource "aws_ecs_cluster_capacity_providers" "ecs_cluster" {
  cluster_name       = aws_ecs_cluster.ecs_cluster.name
  capacity_providers = var.capacity_providers

  default_capacity_provider_strategy {
    base              = var.capacity_provider_base
    weight            = var.capacity_provider_weight
    capacity_provider = var.default_capacity_provider
  }
}


data "template_file" "task_definition_json" {
  template = file("resources/task-definition.json")

}

resource "aws_ecs_task_definition" "web" {
  family                   = var.task_definition_name
  container_definitions    =  data.template_file.task_definition_json.rendered
  network_mode             = var.network_mode
  execution_role_arn       = aws_iam_role.task-test.arn
  cpu                      = var.task_definition_cpu
  memory                   = var.task_definition_memory
  requires_compatibilities = var.requires_compatibilities

  volume {
    name = var.volume_name
  }

}


resource "aws_ecs_service" "web" {
  name                              = var.ecs_service_name
  cluster                           = aws_ecs_cluster.ecs_cluster.id
  task_definition                   = aws_ecs_task_definition.web.arn
  desired_count                     = var.desired_count
  launch_type                       = var.launch_type
  scheduling_strategy               = var.scheduling_strategy
  health_check_grace_period_seconds = var.health_check_grace_period
  deployment_controller {
    type = "CODE_DEPLOY"
  }

  network_configuration {
    subnets = var.subnet_ids
    #subnets          = module.vpc.public_subnets
    security_groups  = [aws_security_group.web_service_sg.id]
    assign_public_ip = var.assign_public_ip
  }

  deployment_maximum_percent         = var.deployment_maximum_percent
  deployment_minimum_healthy_percent = var.deployment_minimum_healthy_percent

  load_balancer {
    target_group_arn = aws_lb_target_group.blue.arn
    container_name   = var.container_name
    container_port   = var.container_port
  }
  depends_on = [
    aws_ecs_task_definition.web,
  ]

}

