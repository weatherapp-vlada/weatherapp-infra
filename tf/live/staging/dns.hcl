locals {
  domain_name = "inviggde.com"
  frontend_base_url = "https://${local.domain_name}"
  backend_url = "api.${local.domain_name}"
  zone_name = "${local.domain_name}."
}