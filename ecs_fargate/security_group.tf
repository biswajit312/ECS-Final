// Security groups Resource File

resource "aws_security_group" "web_service_sg" {
  name        = var.web_service_sg_name
  description = var.web_service_sg_description
  vpc_id      = var.vpc_id
  ingress {
    description = var.web_service_sg_rule_description
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    security_groups = [
      aws_security_group.web_lb.id
    ]
  }

  ingress {
  description = var.web_service_sg_rule_description
  from_port   = 8080
  to_port     = 8080
  protocol    = "tcp"
  security_groups = [
    aws_security_group.web_lb.id
  ]
}

  ingress {
  description = var.web_service_sg_rule_description
  from_port   = 9090
  to_port     = 9090
  protocol    = "tcp"
  security_groups = [
    aws_security_group.web_lb.id
  ]
}


  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = var.tags
}



resource "aws_security_group" "web_lb" {
  name        = var.web_lb_sg_name
  description = var.web_lb_sg_description
  vpc_id      = var.vpc_id

  # ingress {
  #   description = "HTTP"
  #   from_port   = 80
  #   to_port     = 80
  #   protocol    = "tcp"
  #   cidr_blocks = ["0.0.0.0/0"]
  # }

  # ingress {
  #   description = "HTTPS"
  #   from_port   = 443
  #   to_port     = 443
  #   protocol    = "tcp"
  #   cidr_blocks = ["0.0.0.0/0"]
  # }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = var.tags
}

resource "aws_security_group_rule" "web_lb_rules" {
  count             = var.create_sg_rules ? length(var.web_lb_ingress_ports) : 0
  type              = "ingress"
  from_port         = var.web_lb_ingress_ports[count.index]
  to_port           = var.web_lb_ingress_ports[count.index]
  protocol          = var.web_lb_rules_protocol
  security_group_id = aws_security_group.web_lb.id
  cidr_blocks       = var.web_lb_cidr

}
