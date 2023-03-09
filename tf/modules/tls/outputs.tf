output "certificate_arn" {
  value = aws_acm_certificate.myapp.arn
}

output "zone_id" {
  value = data.aws_route53_zone.public.zone_id
}

output "domain_name" {
  value = var.domain_name
}
