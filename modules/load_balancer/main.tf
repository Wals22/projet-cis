# modules/load_balancer/main.tf
resource "aws_lb" "juice_shop_lb" {
  name               = "juice-shop-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.security_group_id]
  subnets            = var.public_subnet_ids

  enable_deletion_protection = false
  tags = {
    Name = "juice-shop-lb"
  }
}

resource "aws_lb_target_group" "juice_shop_tg" {
  name        = "juice-shop-tg"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = "instance"
  health_check {
    path                = "/"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }
}

resource "aws_lb_listener" "juice_shop_http_listener" {
  load_balancer_arn = aws_lb.juice_shop_lb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.juice_shop_tg.arn
  }
}
