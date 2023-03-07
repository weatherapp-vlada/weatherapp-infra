output "url" {
  value = "https://${aws_amplify_domain_association.main.domain_name}"
}