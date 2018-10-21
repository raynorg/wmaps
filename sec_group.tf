# security group
#
resource "aws_security_group" "sg_public" {
  name        = "sg_public"
  description = "Allow incoming 80 + ping only"

  # TODO
  # parameterise ingress ports (using map?)

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  vpc_id = "${module.vpc.vpc_id}"
  tags {
    Name = "sg_public"
  }
}
