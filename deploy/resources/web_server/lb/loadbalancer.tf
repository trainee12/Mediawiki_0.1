resource "aws_lb" "alb" {
  name               = var.name
  subnets            = var.load_balancer_subnets
  security_groups    = var.security_group
  internal           = false
  load_balancer_type = "application"
  tags = {
    Name = var.name
  }
}

resource "aws_lb_target_group" "tg" {
  name     = var.name
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    path              = "/index.php/Main_Page"
    healthy_threshold = 3
    unhealthy_threshold= 2
    interval          = 60
    matcher           = "200-299"
  }

}

resource "aws_lb_listener" "httpd" {
  load_balancer_arn = aws_lb.alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tg.arn
  }
}

resource "aws_lb_listener_rule" "lr" {
  listener_arn = aws_lb_listener.httpd.arn
  priority     = 100

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tg.arn
}

  condition {
    path_pattern {
      values = ["/static/*"]
    }
  }
}


output "dns_loadb" {
 value = aws_lb.alb.dns_name
}
output "target_arn" {
 value = aws_lb_target_group.tg.arn
}