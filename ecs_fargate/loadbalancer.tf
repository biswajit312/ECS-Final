// Load balancer Resource File

resource "aws_lb" "blue" {
  name                       = var.load_balancer_name
  internal                   = var.internal
  load_balancer_type         = var.load_balancer_type
  security_groups            = [aws_security_group.web_lb.id]
  subnets                    = var.subnet_ids
  enable_deletion_protection = var.enable_deletion_protection
  tags                       = var.tags
}

resource "aws_lb_target_group" "blue" {
  name        = var.blue_target_group_name
  port        = var.blue_target_group_port
  protocol    = var.target_group_protocol
  target_type = var.target_group_target_type
  vpc_id      = var.vpc_id

  # depends_on = [aws_lb.web]

  health_check {
    path                = var.target_group_health_check_path
    matcher             = var.target_group_matcher
    enabled             = var.health_check_enabled
    interval            = var.health_check_interval
    protocol            = var.health_check_protocol
    timeout             = var.health_check_timeout
    healthy_threshold   = var.health_check_healthy_threshold
    unhealthy_threshold = var.health_check_unhealthy_threshold
  }

}


resource "aws_lb_target_group" "green" {
  name        = var.green_target_group_name
  port        = var.green_target_group_port
  protocol    = var.target_group_protocol
  target_type = var.target_group_target_type
  vpc_id      = var.vpc_id

  # depends_on = [aws_lb.web]

  health_check {
    path                = var.target_group_health_check_path
    matcher             = var.target_group_matcher
    enabled             = var.health_check_enabled
    interval            = var.health_check_interval
    protocol            = var.health_check_protocol
    timeout             = var.health_check_timeout
    healthy_threshold   = var.health_check_healthy_threshold
    unhealthy_threshold = var.health_check_unhealthy_threshold
  } 

}

resource "aws_lb_listener" "green" {
  load_balancer_arn = aws_lb.blue.arn
  port              = var.green_listener_port
  protocol          = "HTTP"


  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.green.arn
  }
}



resource "aws_lb_listener" "blue" {
  load_balancer_arn = aws_lb.blue.arn
  port              = var.blue_listener_port
  protocol          = "HTTP"


  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.blue.arn
  }
}

# resource "aws_lb_listener" "web_443" {
#   load_balancer_arn = aws_lb.web.arn
#   port              = "443"
#   protocol          = "HTTPS"
#   # ssl_policy        = "ELBSecurityPolicy-2016-08"
#   # certificate_arn   = data.aws_acm_certificate.main.arn

#   default_action {
#     type             = "forward"
#     target_group_arn = aws_lb_target_group.web.arn
#   }
# }
