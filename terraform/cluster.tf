resource "google_container_cluster" "default" {
  name               = var.cluster_name
  location           = var.region
  enable_autopilot   = true
  network            = google_compute_network.default.id
  subnetwork         = google_compute_subnetwork.default.id
  enable_l4_ilb_subsetting = true

  ip_allocation_policy {
    stack_type                    = "IPV4_IPV6"
    services_secondary_range_name = google_compute_subnetwork.default.secondary_ip_range[0].range_name
    cluster_secondary_range_name  = google_compute_subnetwork.default.secondary_ip_range[1].range_name
  }

  node_config {
    service_account = google_service_account.gke_sa.email

    oauth_scopes = [
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring.write",
      "https://www.googleapis.com/auth/devstorage.read_only", # Required to pull images from GCR
    ]
  }

}

