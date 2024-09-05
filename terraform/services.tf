resource "google_container_registry" "registry" {
  project = var.project_id
}

resource "google_project_service" "gke" {
  project = var.project_id
  service = "container.googleapis.com" # Enables the GKE API
}

resource "google_project_service" "compute" {
  project = var.project_id
  service = "compute.googleapis.com" # Enables the Compute Engine API (required by GKE)
}

resource "google_project_service" "cloudresourcemanager" {
  project = var.project_id
  service = "cloudresourcemanager.googleapis.com"
}