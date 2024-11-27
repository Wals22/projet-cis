resource "aws_autoscaling_group" "juice_shop_asg" {
  vpc_zone_identifier     = var.public_subnet_ids
  launch_template {
    id      = var.launch_template_id
    version = "$Latest"
  }
  min_size               = 1
  max_size               = 5
  desired_capacity       = 2
  health_check_grace_period = 300
  health_check_type      = "EC2"

  target_group_arns = [var.tg_arn]

  tag {
    key                 = "Name"
    value               = "Juice-Shop-Instance"
    propagate_at_launch = true
  }
}
