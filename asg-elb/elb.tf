// Creates NLB
resource "aws_lb" "web" {
  name               = var.nlb_name
  internal           = false
  load_balancer_type = "network"

  subnets = data.aws_subnet.test_subnet.*.id
  tags = {
    nlb_terraform = "web"
  }
}


// Creates target group.
resource "aws_lb_target_group" "web" {
  name     = var.target_group_name
  port     = 80
  protocol = "TCP"
  vpc_id   = "vpc-0d9cce260f6f48c31"
  tags = {
    target_group_terraform = "web"
  }
}

resource "aws_lb_listener" "web" {
  load_balancer_arn = aws_lb.web.arn
  port              = 80
  protocol          = "TCP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.web.arn
  }
 
}

output "nlb-url" {
  value = aws_lb.web.dns_name
}