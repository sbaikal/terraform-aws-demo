resource "aws_security_group" "ec2_sg" {
  name        = var.sg_name
  description = "allow traffic from/to ec2 sg"
  vpc_id      = var.vpc_id
  tags = merge(
    local.common_tags,
    {
      Name = "${var.env}_ec2_sg"
    }
  )
}

resource "aws_security_group_rule" "ssh_ingress" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = var.ssh_ip_ingress
  security_group_id = aws_security_group.ec2_sg.id
}

resource "aws_security_group_rule" "http_ingress" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = var.http_ip_ingress
  security_group_id = aws_security_group.ec2_sg.id
}

resource "aws_security_group_rule" "egress_rule" {

  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.ec2_sg.id
}  