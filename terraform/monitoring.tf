resource "google_monitoring_uptime_check_config" "api_uptime_check" {
  display_name = "GKE API Uptime Check"
  timeout      = "10s"
  period       = "60s"

  http_check {
    path    = "/healthz"
    port    = 80
    use_ssl = false
  }

  monitored_resource {
    type = "k8s_pod"
    labels = {
      project_id   = var.project_id
      location     = google_container_cluster.default.location
      cluster_name = google_container_cluster.default.name
      namespace_id = kubernetes_namespace.shortletapp.metadata[0].name
    }
  }

  selected_regions = ["usa"]
}

resource "google_monitoring_notification_channel" "email_notification" {
  display_name = "Email Notification"
  type         = "email"

  labels = {
    email_address = var.service_account_email
  }
}

resource "google_monitoring_alert_policy" "uptime_check_alert" {
  display_name = "Uptime Check Failure Alert"

  conditions {
    display_name = "Uptime Check Failed"
    condition_threshold {
      filter          = "metric.type=\"monitoring.googleapis.com/uptime_check/check_passed\" resource.type=\"k8s_pod\""
      duration        = "60s"
      comparison      = "COMPARISON_LT"
      threshold_value = 1.0

      aggregations {
        alignment_period   = "60s"
        per_series_aligner = "ALIGN_RATE"
      }
    }
  }

  notification_channels = [
    google_monitoring_notification_channel.email_notification.id
  ]

  combiner = "AND"
  enabled  = true
}