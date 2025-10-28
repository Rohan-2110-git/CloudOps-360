# ECS Cluster
resource "aws_ecs_cluster" "this" {
  name = var.cluster_name
  tags = { Project = "cloudops-360" }
}

# Task Execution Role (pull from ECR, write logs, etc.)
resource "aws_iam_role" "task_execution_role" {
  name = "${var.service_name}-execution-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect    = "Allow",
      Principal = { Service = "ecs-tasks.amazonaws.com" },
      Action    = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_role_policy_attachment" "task_execution_role_attachment" {
  role       = aws_iam_role.task_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

# Task Definition (Fargate) with CloudWatch logging
resource "aws_ecs_task_definition" "this" {
  family                   = var.service_name
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = var.cpu
  memory                   = var.memory
  execution_role_arn       = aws_iam_role.task_execution_role.arn

  container_definitions = jsonencode([
    {
      name      = var.service_name,
      image     = var.image,
      essential = true,
      portMappings = [{
        containerPort = var.container_port,
        hostPort      = var.container_port,
        protocol      = "tcp"
      }],
      logConfiguration = {
        logDriver = "awslogs",
        options = {
          awslogs-group         = var.log_group_name,
          awslogs-region        = var.aws_region != null ? var.aws_region : "ap-south-1",
          awslogs-stream-prefix = var.service_name
        }
      }
    }
  ])

  depends_on = [aws_cloudwatch_log_group.this]
}
