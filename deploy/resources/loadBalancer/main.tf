resource "aws_lb" "load_balancer" {
  name               = "LoadBalanceMW"
  subnets            = var.load_balancer_subnets
  security_groups    = var.security_group
  internal           = false
  load_balancer_type = "application"
  tags = {
    Name = "LoadBalanceMW"
  }
}

resource "aws_lb_target_group" "target_group" {
  name     = "LBTarget"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    path              = "/"
    healthy_threshold = 3
    unhealthy_threshold= 2
    interval          = 60
    matcher           = "200-299"
  }

}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.load_balancer.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.target_group.arn
  }
}

resource "aws_lb_listener_rule" "lr" {
  listener_arn = aws_lb_listener.http.arn
  priority     = 100

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.target_group.arn
}

  condition {
    path_pattern {
      values = ["/*"]
    }
  }
}


output "dns_loadb" {
 value = aws_lb.load_balancer.dns_name
}
output "target_arn" {
 value = aws_lb_target_group.target_group.arn
}