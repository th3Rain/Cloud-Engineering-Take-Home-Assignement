output "kubernetes_cluster_name" {
  description = "The name of the GKE cluster"
  value       = google_container_cluster.default.name
}

output "api_service_url" {
  description = "The external IP address of the API service"
  value       = kubernetes_service.api_service.status[0].load_balancer.ingress[0].ip
}

output "instance_id" {
  value = google_compute_instance.example_instance.id
}