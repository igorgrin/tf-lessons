resource "aws_ecs_cluster" "test" {
  name = "test-ecs"

  setting {
    name  = "containerInsights"
    value = "enabled"
  }
}
