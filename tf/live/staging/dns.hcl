locals {
  domain_name = "inviggde.com"
  
  zone_name = "${local.domain_name}."
  user_pool_domain = "auth.${local.domain_name}"
  frontend_base_url = "https://${local.domain_name}"
  backend_domain = "api.${local.domain_name}"
  backend_base_url = "https://${local.backend_domain}"
}
