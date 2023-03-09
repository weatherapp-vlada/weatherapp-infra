terraform {
  source = "../../../../modules//dns"
}

include {
  path = find_in_parent_folders()
}
