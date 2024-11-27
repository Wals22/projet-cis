output "lb_arn" {
  value = aws_lb.juice_shop_lb.arn
}

output "tg_arn" {
  value = aws_lb_target_group.juice_shop_tg.arn
}

output "lb_dns_name" {
  value = aws_lb.juice_shop_lb.dns_name
}
