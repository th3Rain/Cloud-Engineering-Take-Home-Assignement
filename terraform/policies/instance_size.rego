package policy

deny[msg] {
  input.resource_type == "google_compute_instance"
  machine_type := input.config.machine_type
  not machine_type == "n1-standard-1"
  not machine_type == "n1-standard-2"
  not machine_type == "n1-standard-4"
  msg = sprintf("Machine type %s is not allowed. Limit instance sizes to n1-standard-1, n1-standard-2, or n1-standard-4.", [machine_type])
}