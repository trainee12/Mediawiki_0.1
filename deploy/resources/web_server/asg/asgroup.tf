resource "aws_launch_configuration" "lc" {
  name             = var.name
  image_id         = var.ami_id
  key_name         = var.key_name
  security_groups  = var.security_group
  instance_type    = var.instance_type
  user_data        = data.template_file.app_setup.rendered
  associate_public_ip_address = true
}


resource "aws_autoscaling_policy" "asp" {
  name                   = var.name
  policy_type            = "TargetTrackingScaling"
  autoscaling_group_name = aws_autoscaling_group.asg.name

  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }

    target_value = 50.0
  }
}

resource "aws_autoscaling_group" "asg" {
  vpc_zone_identifier       = var.ec2_subnets
  name                      = var.name
  max_size                  = var.max_size
  min_size                  = var.min_size
  health_check_grace_period = 560
  health_check_type         = "ELB"
  force_delete              = true
  target_group_arns         = var.target_group
  launch_configuration      = aws_launch_configuration.lc.name
  tag {
    key                 = "Name"
    value               = "${var.name}EC2"
    propagate_at_launch = true
  }
}

data "template_file" "app_setup" {
  template = file("${path.module}/app.tpl")
  vars = {
    db_ip     = var.database_address
    db_name   = var.name
    db_un     = var.username
    db_pw     = var.password
    app_ver   = var.app_ver
    url       = var.lburl
    site_name = var.site_name
  }
}

