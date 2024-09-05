# Create the shortletapp namespace
resource "kubernetes_namespace" "shortletapp" {
  metadata {
    name = "shortletapp"
  }
}

# Deployment in the shortletapp namespace
resource "kubernetes_deployment" "api_deployment" {
  metadata {
    name      = "curtimeapi-deployment"
    namespace = kubernetes_namespace.shortletapp.metadata[0].name  # Corrected with [0]
  }

  spec {
    replicas = 2

    selector {
      match_labels = {
        app = "currenttime-api"
      }
    }

    strategy {
      type = "RollingUpdate"

      rolling_update {
        max_surge       = "50%"  # Number or percentage of pods that can be created above the desired number of pods
        max_unavailable = "50%"  # Number or percentage of pods that can be unavailable during the update
      }
    }

    template {
      metadata {
        labels = {
          app = "currenttime-api"
        }
      }

      spec {
        container {
          name  = "currenttime-api"
          image = "gcr.io/${var.project_id}/currenttime-api:latest"

          # Resource requests and limits
          resources {
            limits = {
              cpu    = "500m"
              memory = "512Mi"
            }
            requests = {
              cpu    = "250m"
              memory = "256Mi"
            }
          }

          # Liveness probe: checks if the application is running
          liveness_probe {
            http_get {
              path = "/healthz"  # Endpoint for health check
              port = 5000
            }
            initial_delay_seconds = 15  # Delay before the probe is initiated
            period_seconds        = 20  # How often the probe is performed
            timeout_seconds       = 1   # Timeout for the probe
            failure_threshold     = 3   # Number of failures before considering the container unhealthy
          }

          # Readiness probe: checks if the application is ready to serve traffic
          readiness_probe {
            http_get {
              path = "/readiness"  # Endpoint to check readiness
              port = 5000
            }
            initial_delay_seconds = 5   # Delay before the probe is initiated
            period_seconds        = 10  # How often the probe is performed
            timeout_seconds       = 1   # Timeout for the probe
            failure_threshold     = 3   # Number of failures before considering the container not ready
          }

          port {
            container_port = 5000
          }
        }
      }
    }
  }
}

# Service in the shortletapp namespace
resource "kubernetes_service" "api_service" {
  metadata {
    name      = "curtimeapi-service"
    namespace = kubernetes_namespace.shortletapp.metadata[0].name  # Corrected with [0]
  }

  spec {
    selector = {
      app = "currenttime-api"
    }

    type = "LoadBalancer"

    port {
      port        = 80
      target_port = 5000
    }
  }
}

# Horizontal Pod Autoscaler (HPA)
resource "kubernetes_horizontal_pod_autoscaler_v2" "api_hpa" {
  metadata {
    name      = "currenttime-api-hpa"
    namespace = kubernetes_namespace.shortletapp.metadata[0].name  # Corrected with [0]
  }

  spec {
    scale_target_ref {
      api_version = "apps/v1"
      kind        = "Deployment"
      name        = kubernetes_deployment.api_deployment.metadata[0].name  # Corrected with [0]
    }

    min_replicas = 1
    max_replicas = 10

    # CPU utilization target
    metric {
      type = "Resource"
      resource {
        name = "cpu"
        target {
          type                = "Utilization"
          average_utilization = 80  # Trigger scale up when CPU usage is over 80%
        }
      }
    }

    # Memory utilization target
    metric {
      type = "Resource"
      resource {
        name = "memory"
        target {
          type                = "Utilization"
          average_utilization = 80  # Trigger scale up when Memory usage is over 80%
        }
      }
    }
  }
}