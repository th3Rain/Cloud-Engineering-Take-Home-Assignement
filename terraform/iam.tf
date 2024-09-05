resource "google_service_account" "gke_sa" {
  account_id   = "gke-node-sa"
  display_name = "GKE Node Service Account"
  project      = var.project_id
}

resource "google_project_iam_binding" "gke_sa_binding" {
  project = var.project_id
  role    = "roles/storage.objectViewer" # Required to pull images from GCR

  members = [
    "serviceAccount:${google_service_account.gke_sa.email}"
  ]
}

resource "google_project_iam_binding" "gke_cluster_admin" {
  project = var.project_id
  role    = "roles/container.clusterAdmin"

  members = [
    "serviceAccount:${google_service_account.gke_sa.email}"
  ]
}