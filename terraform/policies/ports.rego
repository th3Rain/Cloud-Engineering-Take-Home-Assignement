package policy

deny[msg] {
  input.resource_type == "google_compute_firewall"
  allow := input.config.allow[_]
  allow.ports[_] != "22"
  msg = sprintf("Port %s should be closed", [allow.ports[_]])
}