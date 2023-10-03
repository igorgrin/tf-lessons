resource "aws_ecs_task_definition" "test" {
  family = "test"
  container_definitions = jsonencode([
    {
      name      = "test"
      image     = "394357065274.dkr.ecr.us-west-2.amazonaws.com/test-repo:latest"
      cpu       = 10
      memory    = 512
      essential = true
      portMappings = [
        {
          containerPort = 8080
          hostPort      = 8080
        }
      ]
    }
  ])

  volume {
    name      = "service-storage"
    host_path = "/ecs/service-storage"
  }

  placement_constraints {
    type       = "memberOf"
    expression = "attribute:ecs.availability-zone in [us-west-2a]"
  }
}
