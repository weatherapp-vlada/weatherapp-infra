terraform {
  source = "../../modules//dns"
}

include {
  path = find_in_parent_folders()
}

inputs = {
  zone_name = "inviggde.com."
  domain_name = "api.inviggde.com"
}
