resource "aws_iam_role" "codedeploy_role" {
  name = "codedeploy_role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "codedeploy.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}

EOF
}

resource "aws_iam_policy" "loadbalancer_policy" {
  name        = "loadbalancer_policy_code_deploy"
  path        = "/"
  description = "policy for codedeploy bluegreen"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
    "Version": "2012-10-17"
    "Statement": [
        {
            "Action": [
                "elasticloadbalancing:*",
                "ecs:*"
            ],
            "Effect": "Allow",
            "Resource": "*"
        },
        {
            "Action": "iam:PassRole",
            "Effect": "Allow",
            "Resource": [
                "*"
            ],
            "Condition": {
                "StringLike": {
                    "iam:PassedToService": "ecs-tasks.amazonaws.com"
                }
            }
        }
    ],
  })
}


resource "aws_iam_role_policy_attachment" "AWSCodeDeployRole" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSCodeDeployRole"
  role       = aws_iam_role.codedeploy_role.name
}

resource "aws_iam_role_policy_attachment" "AWSCodeDeployRole_loadbalancer" {
  policy_arn = aws_iam_policy.loadbalancer_policy.arn
  role       = aws_iam_role.codedeploy_role.name
}


resource "aws_iam_policy" "ecs_policy" {
  name        = "appmod_ecs_policy"
  path        = "/"
  description = "ecs policy"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [   
      {
        Action = [             
        "ecr:GetAuthorizationToken",
        "ecr:BatchCheckLayerAvailability",
        "ecr:GetDownloadUrlForLayer",
        "ecr:BatchGetImage",
        "logs:CreateLogStream",
        "logs:PutLogEvents",
        "ecr:BatchCheckLayerAvailability",
        "ecr:GetDownloadUrlForLayer",
        "ecr:BatchGetImage",
        "logs:CreateLogStream",
        "logs:PutLogEvents",
        "ec2:AuthorizeSecurityGroupIngress",
        "ec2:Describe*",
        "elasticloadbalancing:DeregisterInstancesFromLoadBalancer",
        "elasticloadbalancing:DeregisterTargets",
        "elasticloadbalancing:Describe*",
        "elasticloadbalancing:RegisterInstancesWithLoadBalancer",
        "elasticloadbalancing:RegisterTargets"

        ]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })
}

resource "aws_iam_role" "ecs_role" {
  name               = "ecs_role"
  assume_role_policy = <<EOF
{
    "Version": "2008-10-17",
    "Statement": [
        {
            "Sid": "",
            "Effect": "Allow",
            "Principal": {
                "Service": [
                  "ecs.amazonaws.com",
                  "ecs-tasks.amazonaws.com"
                  ]
            },
            "Action": "sts:AssumeRole"
        }
    ]
}
EOF

}

resource "aws_iam_role_policy_attachment" "ecs_role" {
  policy_arn = aws_iam_policy.ecs_policy.arn
  role       = aws_iam_role.ecs_role.name
} 
