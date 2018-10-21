# use cloudposse module to generate ecs container task_definition
# refers to my (hardcoded) aws ecr latest image

module "container_definition" {
  source          = "git::https://github.com/cloudposse/terraform-aws-ecs-container-definition.git?ref=master"
  container_name  = "${var.container_name}"
  container_image = "${var.container_image}"

  port_mappings = [
    {
      containerPort = 80
      hostPort      = 80
      protocol      = "tcp"
    },
  ]
}
