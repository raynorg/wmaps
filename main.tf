# create infrastructure
# create ECS cluster
# create ecs container definition
# create ecs task definition

# Create the basic vpc
# Exposes vpc_id, arn, bunch of other stuff as outputs for later use
#
module "vpc" {
  source = "git::https://github.com/raynorg/tf_vpc"

  vpc_cidr = "${var.vpc_cidr}"
  vpc_name = "${var.vpc_name}"
}

# Create subnet 1
# exposes subnet id and arn for later cluster
#
module subnet1 {
  source     = "git::https://github.com/raynorg/tf_subnet"
  vpc_id     = "${module.vpc.vpc_id}"
  cidr_block = "10.0.64.0/18"
  az         = "us-east-1a"
}

# Create subnet 2
# Different AZ
#
module subnet2 {
  source     = "git::https://github.com/raynorg/tf_subnet"
  vpc_id     = "${module.vpc.vpc_id}"
  cidr_block = "10.0.128.0/18"
  az         = "us-east-1b"
}

# Create Internet gateway
#
module "ig" {
  source  = "git::https://github.com/raynorg/tf_ig"
  vpc_id  = "${module.vpc.vpc_id}"
  ig_name = "ig"
}

# create ecs cluster
#
resource "aws_ecs_cluster" "ecs-cluster" {
  name = "el_clustorio"
}

# create application load balancer
# thanks cloudposse
# output load balancer arn, name etc
#
module "alb" {
  source    = "git::https://github.com/cloudposse/terraform-aws-alb.git?ref=tags/0.2.0"
  namespace = "weedmaps"
  name      = "forum-app"
  stage     = "dev"

  vpc_id          = "${module.vpc.vpc_id}"
  ip_address_type = "ipv4"

  subnet_ids         = ["${module.subnet1.subnet_id}", "${module.subnet2.subnet_id}"]
  access_logs_region = "us-east-1"
  security_group_ids = ["${module.alb.security_group_id}", "${aws_security_group.sg_public.id}"]
}

# use cloudposse module to generate task alb service task_definition
#
module "alb_service_task" {
  source                    = "git::https://github.com/cloudposse/terraform-aws-ecs-alb-service-task.git?ref=master"
  namespace                 = "weedmaps"
  stage                     = "dev"
  name                      = "app"
  alb_target_group_arn      = "${module.alb.default_target_group_arn}"
  container_definition_json = "${module.container_definition.json}"
  container_name            = "${var.container_name}"
  container_port            = "80"
  ecs_cluster_arn           = "${aws_ecs_cluster.ecs-cluster.arn}"
  launch_type               = "FARGATE"
  vpc_id                    = "${module.vpc.vpc_id}"
  security_group_ids        = ["${module.alb.security_group_id}", "${aws_security_group.sg_public.id}"]
  private_subnet_ids        = ["${module.subnet1.subnet_id}", "${module.subnet2.subnet_id}"]

  # added an otherwise useless tag here
  # because tf misses an inherent dependency
  # so this abomination will have to do.
  tags {
    name = "${module.ig.ig_id}"
  }
}
