
output "url" {
  value = "https://${aws_amplify_domain_association.main.domain_name}"
}

output "zone_id" {
  value = data.aws_route53_zone.public.zone_id
}

output "domain_name" {
  value = var.domain_name
}

output "backend_url" {
  value = "https://${aws_route53_record.myapp.fqdn}"
}
