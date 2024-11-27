output "lb_url" {
  description = "Load balancer DNS"
  value       = module.load_balancer.lb_dns_name
}
