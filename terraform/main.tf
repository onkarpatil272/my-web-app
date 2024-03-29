
provider "aws" {
  region = "ap-south-1"
}

resource "aws_ecr_repository" "app_repo" {
  name = "web-app"
}

resource "aws_ecs_cluster" "app_cluster" {
  name = "web-app-cluster"
}

resource "aws_ecs_task_definition" "app_task_definition" {
  family                   = "task"
  container_definitions    = file("${path.module}/ecs_container_definitions.json")
}

resource "aws_ecs_service" "app_service" {
  name            = "services-1"
  cluster         = aws_ecs_cluster.app_cluster.id
  task_definition = aws_ecs_task_definition.app_task_definition.arn
  desired_count   = 1


}
output "ecs_service_url" {
  value = aws_ecs_service.app_service.name
}
