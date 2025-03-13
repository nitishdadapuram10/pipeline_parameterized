
resource "aws_lb" "my_alb" {
  name               = "my-alb"

  load_balancer_type = "application"
  security_groups    = [aws_security_group.my_alb_sg.id]
  subnets            = [var.public_subnet_id1, var.public_subnet_id2, var.private_subnet_id]

 enable_cross_zone_load_balancing = true

  tags = {
    Name = "my_alb"
  }
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.my_alb.arn
  port              = 80
  protocol          = "HTTP"


  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.my_ec2_target_group.arn
  }
}

resource "aws_lb_target_group" "my_ec2_target_group" {
  name     = "ec2-target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id


}

resource "aws_lb_target_group_attachment" "attachment" {
  target_group_arn = aws_lb_target_group.my_ec2_target_group.arn
  target_id        = aws_instance.my_private_ec2.id
  port             = 80
}


output "alb_dns_name" {
  value = aws_lb.my_alb.dns_name
}
