resource "aws_launch_template" "linux" {
  name                 = "linux"
  image_id             = "ami-0022f774911c1d690"
  instance_type        = "t2.micro"
  security_group_names = ["web"]
  user_data            = base64encode(file("${path.module}/bash/install-httpd.sh"))
  tags = {
    template_terraform = "linux"
  }
}

resource "aws_autoscaling_group" "web" {
  availability_zones = ["us-east-1a", "us-east-1b", "us-east-1c", "us-east-1d", "us-east-1e", "us-east-1f"]
  desired_capacity   = var.web_desired_capacity
  max_size           = var.web_max_size
  min_size           = var.web_min_size
  target_group_arns  = [aws_lb_target_group.web.arn]
  launch_template {
    id      = aws_launch_template.linux.id
    version = "$Latest"
  }
  tag {
    key                 = "autoscaling"
    value               = "web"
    propagate_at_launch = true
  }
}

resource "aws_autoscaling_schedule" "event" {
  scheduled_action_name  = "event"
  min_size               = 2
  max_size               = 5
  desired_capacity       = 4
  start_time             = "2022-06-09T12:51:00Z"
  end_time               = "2022-06-09T12:59:00Z"
  autoscaling_group_name = aws_autoscaling_group.web.name
}

