package policy

deny[msg] {
  input.resource_type == "google_storage_bucket"
  input.config.encryption == null
  msg = "Encryption must be enabled for storage buckets."
}