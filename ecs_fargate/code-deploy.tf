resource "aws_codedeploy_deployment_config" "custom_canary" {
  deployment_config_name = "EcsCanary25Percent20Minutes"
  compute_platform       = "ECS"
  traffic_routing_config {
    type = "TimeBasedCanary"
    time_based_canary {
      interval   = 2
      percentage = 25
    }
  }
}


resource "aws_codedeploy_app" "node_app" {
  compute_platform = "ECS"
  name             = "deployment-app"
}

resource "aws_codedeploy_deployment_group" "this" {
  app_name               = aws_codedeploy_app.node_app.name
  deployment_config_name = aws_codedeploy_deployment_config.custom_canary.id
  deployment_group_name  = "deployment-group"
  service_role_arn       = aws_iam_role.codedeploy_role.arn

  blue_green_deployment_config {
    deployment_ready_option {
      action_on_timeout = "CONTINUE_DEPLOYMENT"
    }

    terminate_blue_instances_on_deployment_success {
      action                           = "TERMINATE"
      termination_wait_time_in_minutes = 5
    }
  }

  deployment_style {
    deployment_option = "WITH_TRAFFIC_CONTROL"
    deployment_type   = "BLUE_GREEN"
  }

  ecs_service {
    cluster_name = aws_ecs_cluster.ecs_cluster.name
    service_name = aws_ecs_service.web.name
  }

  auto_rollback_configuration {
    enabled = true
    events  = ["DEPLOYMENT_FAILURE"]
  }


  load_balancer_info {
    target_group_pair_info {
      prod_traffic_route {
        listener_arns = [aws_lb_listener.blue.arn]
      }

      test_traffic_route {
        listener_arns = [aws_lb_listener.green.arn]

      }

    target_group {
        name = aws_lb_target_group.blue.name
      }

    target_group {
        name = aws_lb_target_group.green.name
      }
    }
  }
}