package policy

deny[msg] {
  input.config.region != "us-central1"
  input.config.region != "europe-west1"
  msg = sprintf("Resources are only allowed in us-central1 or europe-west1. Found %s.", [input.config.region])
}