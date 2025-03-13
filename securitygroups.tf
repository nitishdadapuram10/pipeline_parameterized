resource "aws_security_group" "my_ec2_sg" {
  name        = "my_ec2_sg"
  description = "Allow traffic from ALB only"
  vpc_id      = var.vpc_id



 egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "my_alb_sg" {
  name        = "my_alb_sg"
  description = "Allowing traffic from internet"
  vpc_id      = var.vpc_id

   ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }


  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}



resource "aws_security_group_rule" "allow_alb_to_ec2" {
  type                     = "ingress"
  port                     = 80
  protocol                 = "tcp"
  security_group_id        = aws_security_group.my_ec2_sg.id
  source_security_group_id = aws_security_group.my_alb_sg.id
}

